# Keep $HOME tidy: point tools at the XDG base directories instead of ~/.<tool>.
# Bash gets the same settings from ~/.bashrc.
#
# Paths are spelled out instead of exporting XDG_CONFIG_HOME & co, so tools
# that derive paths from those variables don't move unexpectedly.

# npm cache (was ~/.npm)
set -gx npm_config_cache $HOME/.cache/npm

# Azure CLI (was ~/.azure)
set -gx AZURE_CONFIG_DIR $HOME/.config/azure

# Azure Functions Core Tools extension bundles (was ~/.azure-functions-core-tools)
set -gx AzureFunctionsJobHost__extensionBundle__downloadPath $HOME/.cache/azure-functions/ExtensionBundles

# Docker CLI config (was ~/.docker)
set -gx DOCKER_CONFIG $HOME/.config/docker

# GnuPG keyring (was ~/.gnupg) - used by pass
set -gx GNUPGHOME $HOME/.local/share/gnupg

# .NET CLI home (was ~/.dotnet, ~/.nuget, ~/.templateengine)
set -gx DOTNET_CLI_HOME $HOME/.local/share/dotnet-cli
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1

# Microsoft 365 MCP server logs (was ~/.ms-365-mcp-server/logs)
set -gx MS365_MCP_LOG_DIR $HOME/.local/state/ms-365-mcp-server/logs

# AI CLIs (were ~/.copilot, ~/.codex)
set -gx COPILOT_HOME $HOME/.config/copilot
set -gx CODEX_HOME $HOME/.config/codex

# Claude Code stays in ~/.claude on purpose: many plugins and skills hardcode
# that path, so CLAUDE_CONFIG_DIR would break them.

# History files (were ~/.psql_history, ~/.python_history, ~/.lesshst, ~/.wget-hsts)
# PYTHON_HISTORY needs Python 3.13+.
set -gx PSQL_HISTORY $HOME/.local/state/psql_history
set -gx PYTHON_HISTORY $HOME/.local/state/python_history
set -gx LESSHISTFILE $HOME/.local/state/lesshst
set -gx WGETRC $HOME/.config/wget/wgetrc

# Terraform: skip the update check, which is all ~/.terraform.d held
set -gx CHECKPOINT_DISABLE 1

# Ubuntu's login banner (/etc/profile.d/update-motd.sh) skips itself when this
# is set, so login bash shells started from fish stop creating ~/.motd_shown
# and ~/.landscape (an alternative to adding a ~/.hushlogin file)
set -gx MOTD_SHOWN fish
