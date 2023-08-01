export test='HELLO WORLD'

# Added locations to path variable
export DOTFILE=/mnt/d/omoi/git/dotfiles

# Installation Path
export bin_path=/usr/local/bin

# Add to PATH
export PATH="$PATH:/home/omoi/.local/bin"

# NVM directory
# export NVM_DIR="$HOME/.nvm"

export STARSHIP_CONFIG=$DOTFILE/.starship/tokyonight_storm.toml

# ********************** Python **********************
source "$DOTFILE/linux/p_lang/python/env/bin/activate"
