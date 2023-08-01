dotfiles=/mnt/d/omoi/git/dotfiles
bash=$dotfiles/linux/shell/.bash

[[ -f "$bash/scripts/env.sh" ]] && source "$bash/scripts/env.sh"
[[ -f "$bash/scripts/aliases.sh" ]] && source "$bash/scripts/aliases.sh"
[[ -f "$bash/scripts/starship.sh" ]] && source "$bash/scripts/starship.sh"
[[ -f "$bash/scripts/functions.sh" ]] && source "$bash/scripts/functions.sh"
# [[ -f "$bash/scripts/up.sh" ]] && source "$bash/scripts/up.sh"

# Load Starship
eval "$(starship init bash)"

# Load Direnv
eval "$(direnv hook bash)"

direnv allow