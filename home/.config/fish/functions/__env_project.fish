function __env_project --description "Resolve project name for env-* helpers (arg, else git root / cwd basename)"
    if test -n "$argv[1]"; and test "$argv[1]" != "."
        echo $argv[1]
        return
    end
    set -l root (git rev-parse --show-toplevel 2>/dev/null)
    test -n "$root"; or set root $PWD
    basename $root
end
