function env-sync --wraps envctl --description "envctl sync: git pull --rebase + push"
    envctl sync $argv
end
