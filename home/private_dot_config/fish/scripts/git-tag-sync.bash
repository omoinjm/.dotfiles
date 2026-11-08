# bash: source from ~/.bashrc. `git tag <version>` keeps version files in step with the tag.
# shellcheck shell=bash
__git_tag_sync="${BASH_SOURCE[0]%.bash}"
git() {
    if [[ ${1-} == tag ]]; then
        shift
        "$__git_tag_sync" "$@"
    else
        command git "$@"
    fi
}
