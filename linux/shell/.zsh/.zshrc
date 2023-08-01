[[ -f ~/.zsh/scripts/main.zsh ]] && source ~/.zsh/scripts/main.zsh
[[ -f ~/.zsh/scripts/aliases.zsh ]] && source ~/.zsh/scripts/aliases.zsh
[[ -f ~/.zsh/scripts/starship.zsh ]] && source ~/.zsh/scripts/starship.zsh
[[ -f ~/.zsh/scripts/functions.zsh ]] && source ~/.zsh/scripts/functions.zsh
[[ -f ~/.zsh/scripts/up.zsh ]] && source ~/.zsh/scripts/up.zsh

# Load Starship
eval "$(starship init zsh)"

# Load Direnv
# https://direnv.net/
eval "$(direnv hook zsh)"
