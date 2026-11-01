function env-backup-all --wraps envctl --description "envctl backup-all: scan for .env/.env.local, store new/changed ones"
    envctl backup-all $argv
end
