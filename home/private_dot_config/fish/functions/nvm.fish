function nvm
    set -q NVM_DIR; or set -gx NVM_DIR "$HOME/.local/share/nvm"
    bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
end
