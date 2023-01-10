# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias idea idea64
Set-Alias -Name eth -Value Get-NetAdapter
Set-Alias -Name Pywal-Starship -Value pywal_to_starship
Set-Alias -Name Wallpaper-Starship -Value update_pywal_to_starship
Set-Alias -Name Screenshot-Starship -Value screenshot_to_pywal_to_starship
Set-Alias -Name vim nvim
Set-Alias -Name curl -Value "C:\Program Files\Git\mingw64\bin\curl.exe" -Option AllScope

## Directoies
. $HOME\.config\powershell\dirs.ps1

# Utilities

## Find program location
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

## Find any file in the system
function find-file($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        $place_path = $_.directory
        Write-Output "${place_path}\${_}"
    }
}

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

## add and commit 
function gcommit($dir, $message) {
  git add "$dir"
  git commit -m "$message"
}

## delete local branch
function gdelete($branch) {
	git branch -D $branch
}


