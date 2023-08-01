#!/bin/bash

# Alias
# ---
#
# alias ls='ls --color=auto'
alias grep='grep --color'
alias lla='ls -la'
alias k="kubectl"
alias ls='ls -l --color=auto'
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -A'
alias cls=clear
alias vim=nvim
alias vi=nvim

# alias l='ls -F'
command -v lsd > /dev/null && alias ls='lsd --group-dirs first' && \
	alias tree='lsd --tree'
command -v colorls > /dev/null && alias ls='colorls --sd --gs' && \
	alias tree='colorls --tree'


