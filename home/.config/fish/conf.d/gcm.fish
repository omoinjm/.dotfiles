# Tab after `git commit -m` (or --message, -am) inserts an AI commit message.
# Lives in conf.d rather than completions/git.fish so fish's built-in git completions still load.
#
# Generation never blocks Tab: after `git add` (or `g add`), the suggestion
# is generated in the background (__gcm_prefetch) and Tab just reads the cached result.

functions -q __gcm_suggest # autoload functions/__gcm_suggest.fish, which also defines __gcm_prefetch

function __gcm_on_git --on-event fish_postexec
    string match -qr '^\s*(git|g)\s+add(\s|$)' -- $argv[1]; or return
    __gcm_prefetch
end

function __gcm_in_commit
    contains -- commit (commandline -opc)
end

function __gcm_complete_message
    set -l result (__gcm_suggest --cached 2>/dev/null)
    if test -n "$result[1]"
        printf '%s\tvia %s\n' $result[1] $result[2]
    else
        # Not ready yet: make sure a background job is on it, try Tab again shortly
        __gcm_prefetch
    end
end

# Attach to the -m/--message option itself: fish's git completions declare it as taking an
# argument (-x), and for an option argument fish only offers that option's own values.
complete -c git -n __gcm_in_commit -s m -l message -x -a '(__gcm_complete_message)'
