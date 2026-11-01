function env-save --description "Save a .env file into pass: env-save [project|.] [file=.env]"
    __env_check; or return 1
    set -l project (__env_project $argv[1])
    set -l file .env
    test -n "$argv[2]"; and set file $argv[2]
    if not test -f $file
        echo "env-save: $file not found" >&2
        return 1
    end
    set -l entry projects/$project/(__env_pass_name $file)
    pass insert -m -f $entry <$file >/dev/null; or return 1
    echo "Saved $file -> $entry"
    pass git push --quiet; or echo "env-save: saved and committed locally, but push failed (run env-sync)" >&2
end
