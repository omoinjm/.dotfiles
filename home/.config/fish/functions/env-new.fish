function env-new --wraps envctl --description "envctl new: create + link this dir's env-vault folder (imports .env if present)"
    envctl new $argv
end
