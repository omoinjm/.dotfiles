# Shared AI commit-message generator for gcm and the `git commit -m` Tab completion.
# Suggestions are cached per staged diff in ~/.cache/gcm (line 1 = message, line 2 = source),
# so __gcm_prefetch can fill the cache in the background and Tab only ever reads it.

function __gcm_key --description "md5 of the staged diff (fails if nothing staged)"
    set -l diff (git diff --cached 2>/dev/null | string collect)
    test -z "$diff"; and return 1
    printf '%s' $diff | md5sum | string split -f1 ' '
end

function __gcm_suggest --description "Print the commit suggestion for staged changes: line 1 = message, line 2 = source"
    # --cached: only return an existing suggestion, never generate or wait (used by Tab)
    argparse cached -- $argv; or return 1
    set -l key (__gcm_key); or return 1
    set -l cache ~/.cache/gcm/$key
    set -l lock $cache.lock
    find $lock -mmin +1 -delete 2>/dev/null # stale lock from a killed job

    # A background prefetch is already generating this one: wait for it instead of calling the AI twice
    if not set -q _flag_cached; and not test -s $cache; and test -e $lock
        echo "Waiting for background suggestion..." >&2
        for i in (seq 70)
            if test -s $cache; or not test -e $lock
                break
            end
            sleep 0.5
        end
    end

    if test -s $cache
        cat $cache
        return 0
    end
    set -q _flag_cached; and return 1
    __gcm_generate; and cat $cache
end

function __gcm_prefetch --description "Generate the commit suggestion in a background job"
    set -l key (__gcm_key); or return 0
    set -l dir ~/.cache/gcm
    test -s $dir/$key; and return 0
    find $dir/$key.lock -mmin +1 -delete 2>/dev/null
    test -e $dir/$key.lock; and return 0

    mkdir -p $dir
    find $dir -type f -mmin +1440 -delete 2>/dev/null # drop suggestions older than a day
    touch $dir/$key.lock
    set -l src (functions --details __gcm_prefetch)
    fish --no-config -c "source $src; __gcm_generate; rm -f $dir/$key.lock" </dev/null &>/dev/null &
    disown 2>/dev/null
end

function __gcm_generate --description "Call Claude, falling back to Cloudflare Workers AI, and cache the result"
    set -l diff (git diff --cached 2>/dev/null | string collect)
    test -z "$diff"; and return 1
    set -l key (printf '%s' $diff | md5sum | string split -f1 ' ')

    set -l prompt "Write a concise Conventional Commit message (single subject line, max 72 chars) for this diff. Output only the message, no quotes, no code fences, no explanation."

    # Config: shell env vars win, otherwise read from the env file
    set -l env_file ~/.config/gcm/.env
    set -q GCM_ENV_FILE; and set env_file $GCM_ENV_FILE
    set -l cf_account $CF_ACCOUNT_ID
    set -l cf_token $CF_API_TOKEN
    set -l cf_model $CF_AI_MODEL
    if test -f $env_file
        for line in (cat $env_file | string match -rv '^\s*(#|$)')
            set -l kv (string split -m1 = -- $line)
            set -l k (string trim -- $kv[1])
            set -l val (string trim -- $kv[2] | string trim -c '"\'')
            switch $k
                case CF_ACCOUNT_ID
                    test -z "$cf_account"; and set cf_account $val
                case CF_API_TOKEN
                    test -z "$cf_token"; and set cf_token $val
                case CF_AI_MODEL
                    test -z "$cf_model"; and set cf_model $val
            end
        end
    end
    test -z "$cf_model"; and set cf_model @cf/meta/llama-3.3-70b-instruct-fp8-fast

    set -l msg
    set -l source
    set -l tmp (mktemp)

    # 1. Claude
    echo "Generating commit message (claude)..." >&2
    if printf '%s' $diff | timeout 30 claude -p $prompt >$tmp 2>/dev/null
        set msg (string collect <$tmp)
        set source claude
    end

    # 2. Cloudflare Workers AI fallback
    if test -z "$msg"
        if test -n "$cf_account" -a -n "$cf_token"
            echo "Claude unavailable, falling back to Cloudflare Workers AI..." >&2
            set -l body (jq -nc --arg prompt $prompt --arg diff (string sub -l 12000 -- $diff | string collect) \
                '{messages: [{role: "system", content: $prompt}, {role: "user", content: $diff}]}' | string collect)
            if curl -sf --max-time 30 \
                    -H "Authorization: Bearer $cf_token" \
                    -H "Content-Type: application/json" \
                    -d $body \
                    "https://api.cloudflare.com/client/v4/accounts/$cf_account/ai/run/$cf_model" \
                    | jq -r '.result.response // empty' >$tmp 2>/dev/null
                set msg (string collect <$tmp)
                set source cloudflare
            end
        else
            echo "Claude unavailable and Cloudflare not configured ($env_file)." >&2
        end
    end
    rm -f $tmp

    # Keep only the first meaningful line (models sometimes add fences or chatter)
    set msg (string split \n -- $msg | string match -rv '^\s*(```.*)?$' | string trim -c ' "`')[1]
    test -z "$msg"; and return 1

    # Write atomically so a concurrent reader never sees a half-written file
    mkdir -p ~/.cache/gcm
    printf '%s\n%s\n' $msg $source >~/.cache/gcm/$key.tmp
    and mv ~/.cache/gcm/$key.tmp ~/.cache/gcm/$key
end
