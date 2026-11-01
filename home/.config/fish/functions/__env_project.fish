function __env_project --description "Resolve project path for env-* helpers: arg, else <git repo>[/<subdir>], else cwd name"
    if test -n "$argv[1]"; and test "$argv[1]" != "."
        echo $argv[1]
        return
    end
    set -l root (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$root"
        # include the subdir so monorepos with several .env files don't collide
        set -l prefix (string replace -r '/$' '' -- (git rev-parse --show-prefix 2>/dev/null))
        if test -n "$prefix"
            # strip leading dots per path segment so `pass ls` (tree) doesn't hide them
            string replace -ra '(^|/)\.+' '$1' -- (basename $root)/$prefix
            return 0
        else
            basename $root
        end
    else
        basename $PWD
    end
end
