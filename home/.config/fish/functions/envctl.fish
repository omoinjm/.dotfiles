function envctl --description "Back up / restore project .env files with pass (see: envctl help)"
    set -l store $HOME/.password-store
    set -q PASSWORD_STORE_DIR; and set store $PASSWORD_STORE_DIR
    $store/scripts/envctl $argv
end
