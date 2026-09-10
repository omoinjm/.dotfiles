# oh-my-posh's git segment (bubblesextra's Ahead/Behind/BranchStatus) only reads
# local refs/remotes — it never talks to the network. Those numbers are only as
# fresh as your last `git fetch`. This fetches quietly in the background,
# rate-limited per repo, whenever you cd into one, so the prompt stays accurate.
function __git_auto_fetch --on-variable PWD --description 'Background git fetch to keep prompt ahead/behind status current'
    status --is-interactive
    or return

    set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
    test -n "$git_dir"
    or return

    set -l fetch_head "$git_dir/FETCH_HEAD"
    set -l threshold 300 # seconds between background fetches, per repo

    if test -f "$fetch_head"
        set -l last (command stat -c %Y "$fetch_head" 2>/dev/null; or command stat -f %m "$fetch_head" 2>/dev/null)
        if test -n "$last"; and test (math (date +%s) - $last) -lt $threshold
            return
        end
    end

    command git fetch --quiet >/dev/null 2>&1 &
    disown
end
