function env-sync --description "Pull + push the password store"
    __env_check; or return 1
    pass git pull --rebase; and pass git push
end
