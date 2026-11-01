function __env_check --description "Ensure pass and the password store are available"
    if not type -q pass
        echo "env: 'pass' is not installed (sudo apt install pass / brew install pass)" >&2
        return 1
    end
    set -l dir $HOME/.password-store
    set -q PASSWORD_STORE_DIR; and set dir $PASSWORD_STORE_DIR
    if not test -f "$dir/.gpg-id"
        echo "env: no password store at '$dir' (git clone git@github.com:omoinjm/password-store.git ~/.password-store)" >&2
        return 1
    end
end
