function env-edit --description "Edit a stored .env in \$EDITOR: env-edit [project|.] [file=.env]"
    __env_check; or return 1
    set -l project (__env_project $argv[1])
    set -l file .env
    test -n "$argv[2]"; and set file $argv[2]
    pass edit projects/$project/(__env_pass_name $file); or return 1
    pass git push --quiet; or echo "env-edit: committed locally, but push failed (run env-sync)" >&2
end
