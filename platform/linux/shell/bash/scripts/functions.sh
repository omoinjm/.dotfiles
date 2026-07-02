#!/bin/bash

# Colormap
function colormap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# fzf ctrl-r and alt-c behavior
export FZF_DEFAULT_COMMAND="fzf "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND – type d"

# ************************ GIT ******************************

# Git commands
function gpull { git pull origin master; }
function gpush { git push origin master; }
function gcheck { git checkout master; }
function gs { git status; }
function gres { git restore .; }

## See commits
function glg { git log; }
 
## all commits on all branches that have not been pushed 
function glog {
   git log --branches --not --remotes
}

## most recent commit on each branch
function gloge {
   git log --branches --not --remotes --simplify-by-decoration --decorate --oneline
}

## add, commit and push
function acp() {
   git add .
   git commit -m "$1"
   git push origin HEAD
}