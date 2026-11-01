function env-ls --description "List stored .env files: env-ls [project|.] (no arg = all projects)"
    __env_check; or return 1
    if test (count $argv) -eq 0
        pass ls projects
    else
        pass ls projects/(__env_project $argv[1])
    end
end
