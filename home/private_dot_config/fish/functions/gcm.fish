function gcm --description "AI-suggested commit message from staged changes"
    if test -z "$(git diff --cached 2>/dev/null)"
        echo "Nothing staged. Run git add first."
        return 1
    end

    # Uses whichever provider answers first (usually Cloudflare in ~1s)
    set -l result (__gcm_suggest)
    set -l msg $result[1]

    if test -n "$msg"
        echo "[via $result[2]]"
    else
        echo "No suggestion available, type your message."
    end

    # Pre-fill the prompt with the suggestion; edit it, then press Enter (Ctrl+C to abort)
    read --command "$msg" --prompt-str "commit> " final
    and test -n "$final"
    and git commit -m "$final"
end
