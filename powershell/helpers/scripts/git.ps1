# Git commands
function gpull { git pull origin master }
function gpush { git push origin master }
function gcheck { git checkout master }
function gs { git status }
function gres { git restore . }

## See commits
function glg { git log }
 
## all commits on all branches that have not been pushed 
function glog {
   git log --branches --not --remotes
}

## most recent commit on each branch
function gloge {
   git log --branches --not --remotes --simplify-by-decoration --decorate --oneline
}

## add, commit and push
function acp($message) {
   git add .
   git commit -m "$message"
   git push origin HEAD
}
