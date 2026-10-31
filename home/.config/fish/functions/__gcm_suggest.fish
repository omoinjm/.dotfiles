# Shared AI commit-message generator for gcm and the `git commit -m` Tab completion.
# Suggestions are cached per staged diff in ~/.cache/gcm (line 1 = message, line 2 = source).
# __gcm_prefetch races Cloudflare Workers AI (~1s) against Claude (~6s) in the background:
# Cloudflare's answer lands first, then Claude's replaces it when (and if) it arrives.

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

    if not test -s $cache; and not set -q _flag_cached
        __gcm_prefetch
        echo "Generating commit message..." >&2
        # Take the first answer from either provider; give up once the job ends without one
        for i in (seq 70)
            if test -s $cache; or not test -e $cache.lock
                break
            end
            sleep 0.5
        end
    end

    test -s $cache; or return 1
    cat $cache
end

function __gcm_prefetch --description "Generate the commit suggestion in a background job"
    set -l key (__gcm_key); or return 0
    set -l dir ~/.cache/gcm
    test -s $dir/$key; and return 0
    find $dir/$key.lock -mmin +1 -delete 2>/dev/null # stale lock from a killed job
    test -e $dir/$key.lock; and return 0

    mkdir -p $dir
    find $dir -type f -mmin +1440 -delete 2>/dev/null # drop suggestions older than a day
    touch $dir/$key.lock
    set -l src (functions --details __gcm_prefetch)
    set -l run "fish --no-config -c 'source $src; __gcm_generate"
    sh -c "$run cloudflare' & $run claude' & wait; rm -f $dir/$key.lock" </dev/null &>/dev/null &
    disown 2>/dev/null
end

function __gcm_generate --description "Ask one provider (claude|cloudflare) for a message and cache it"
    set -l provider $argv[1]
    set -l diff (git diff --cached 2>/dev/null | string collect)
    test -z "$diff"; and return 1
    set -l key (printf '%s' $diff | md5sum | string split -f1 ' ')
    set -l cache ~/.cache/gcm/$key

    set -l prompt "Write a concise Conventional Commit message (single subject line, max 72 chars) for this diff. Output only the message, no quotes, no code fences, no explanation."
    set -l tmp (mktemp)
    set -l msg

    switch $provider
        case claude
            # Lean mode: skipping plugins, hooks, MCP servers and tools cuts startup from ~19s to ~6s
            if printf '%s' $diff | timeout 30 claude -p $prompt --strict-mcp-config --tools "" \
                    --disable-slash-commands --no-session-persistence --setting-sources "" >$tmp 2>/dev/null
                set msg (string collect <$tmp)
            end

        case cloudflare
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

            if test -n "$cf_account" -a -n "$cf_token"
                set -l body (jq -nc --arg prompt $prompt --arg diff (string sub -l 12000 -- $diff | string collect) \
                    '{messages: [{role: "system", content: $prompt}, {role: "user", content: $diff}]}' | string collect)
                if curl -sf --max-time 30 \
                        -H "Authorization: Bearer $cf_token" \
                        -H "Content-Type: application/json" \
                        -d $body \
                        "https://api.cloudflare.com/client/v4/accounts/$cf_account/ai/run/$cf_model" \
                        | jq -r '.result.response // empty' >$tmp 2>/dev/null
                    set msg (string collect <$tmp)
                end
            end

        case '*'
            echo "__gcm_generate: unknown provider '$provider'" >&2
            rm -f $tmp
            return 1
    end
    rm -f $tmp

    # Keep only the first meaningful line (models sometimes add fences or chatter)
    set msg (string split \n -- $msg | string match -rv '^\s*(```.*)?$' | string trim -c ' "`')[1]
    test -z "$msg"; and return 1

    # Never let the faster Cloudflare answer overwrite Claude's if Claude finished first
    if test $provider = cloudflare; and test "$(sed -n 2p $cache 2>/dev/null)" = claude
        return 0
    end

    # Write atomically so a concurrent reader never sees a half-written file
    mkdir -p ~/.cache/gcm
    printf '%s\n%s\n' $msg $provider >$cache.$provider.tmp
    and mv $cache.$provider.tmp $cache
end
