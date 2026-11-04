# Keep $HOME tidy: point tools at the XDG base directories instead of ~/.<tool>.
# Bash gets the same settings from ~/.bashrc.
#
# Paths are spelled out instead of exporting XDG_CONFIG_HOME & co: ~/.bashrc
# picks NVM_DIR based on XDG_CONFIG_HOME, so exporting it would move nvm.

# npm cache (was ~/.npm)
set -gx npm_config_cache $HOME/.cache/npm

# Azure CLI (was ~/.azure)
set -gx AZURE_CONFIG_DIR $HOME/.config/azure

# Docker CLI config (was ~/.docker)
set -gx DOCKER_CONFIG $HOME/.config/docker

# History files (were ~/.psql_history, ~/.python_history, ~/.lesshst, ~/.wget-hsts)
# PYTHON_HISTORY needs Python 3.13+.
set -gx PSQL_HISTORY $HOME/.local/state/psql_history
set -gx PYTHON_HISTORY $HOME/.local/state/python_history
set -gx LESSHISTFILE $HOME/.local/state/lesshst
set -gx WGETRC $HOME/.config/wget/wgetrc
