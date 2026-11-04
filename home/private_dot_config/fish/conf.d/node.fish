set -gx PATH node_modules/.bin $PATH

# nvm (XDG data dir instead of ~/.nvm)
set -gx NVM_DIR "$HOME/.local/share/nvm"

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
