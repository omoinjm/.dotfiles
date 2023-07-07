[[ -f ~/.zsh/main.zsh ]] && source ~/.zsh/main.zsh
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh
[[ -f ~/.zsh/nvm.zsh ]] && source ~/.zsh/nvm.zsh
[[ -f ~/.zsh/wsl2fix.zsh ]] && source ~/.zsh/wsl2fix.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/up.zsh ]] && source ~/.zsh/up.zsh

# Load Starship
#eval "$(starship init zsh)"

# Load Direnv
eval "$(direnv hook zsh)"
