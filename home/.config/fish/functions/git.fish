# `git tag <version>` keeps the project's version files in step with the tag (see scripts/git-tag-sync).
# Everything else goes straight to git. `command git tag ...` or `git tag ... --no-sync` skips it.
function git --description 'git, with version-file sync on git tag'
    if test "$argv[1]" = tag
        $__fish_config_dir/scripts/git-tag-sync $argv[2..-1]
    else
        command git $argv
    end
end
