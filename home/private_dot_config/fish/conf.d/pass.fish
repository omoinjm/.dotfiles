# pass store = clone of git@github.com:omoinjm/password-store.git at ~/dev/github/config/password-store
# (~/.password-store is a symlink to it for tools that assume the default location)
set -gx PASSWORD_STORE_DIR $HOME/dev/github/config/password-store
if status is-interactive
    set -gx GPG_TTY (tty)
end
