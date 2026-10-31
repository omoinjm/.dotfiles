# direnv: load per-directory .envrc (e.g. project-specific AWS_PROFILE)
if status is-interactive; and command -q direnv
    direnv hook fish | source
end
