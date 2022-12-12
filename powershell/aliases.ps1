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

## delete local branch
function gdelete($branch) {
	git branch -D $branch
}

# Open VSC and Serve
function cng { code . && ng serve -o }

# Work repos

### CHRONODESK
function chrono { cd "D:\Rysis\Git\rysis-chronolog\" }
function chronoApi { cd "D:\Rysis\Git\rysis-chronolog\Timesheet_API\" }
function chronoWeb { cd "D:\Rysis\Git\rysis-chronolog\Timesheet_Web\ClientApp\" }
function chronoSql { cd "D:\Rysis\Git\rysis-chronolog\Timesheet_Midtier\SqlProxyClassGen\" }

### VISIBILL
function visibill { cd "D:\Rysis\Git\visibill-4\" }
function visibillApi { cd "D:\Rysis\Git\visibill-4\Visibill_API" }
function visibillWeb { cd "D:\Rysis\Git\visibill-4\VisibillWeb\ClientApp" }
function visibillSql { cd "D:\Rysis\Git\visibill-4\Visibill_Midtier\SqlProxyClassGen\" }

### VELOCITY
function velo { cd "D:\Rysis\Git\rysis-driverisk2\" }
function veloApi { cd "D:\Rysis\Git\rysis-driverisk2\DriveRisk.Api" }
function veloWeb { cd "D:\Rysis\Git\rysis-driverisk2\DriveRisk.Drops\ClientApp\" }
function veloSql { cd "D:\Rysis\Git\rysis-driverisk2\DriveRisk.Midtier\SqlProxyClassGen\" }

### DRIVERISK
function drive { cd "D:\Rysis\Git\rysis-driverisk\" }
function drops { cd "D:\Rysis\Git\rysis-driverisk\DriveRisk.Drops.WebApp\" }

### SAHCS
function sahiv { cd "D:\Rysis\GIT\rysis-sahiv\Website\" }
function sahivApi { cd "D:\Rysis\Git\rysis-sahiv\Website\SahivV3_Api" }
function sahivSql { cd "D:\Rysis\GIT\rysis-sahiv\Website\Sahiv.Midtier2\Bat2\" }
function sahivWeb { cd "D:\Rysis\Git\rysis-sahiv\Website\SahivV3_Angular\ClientApp" }

### ATRAX
function atrax { cd "D:\Rysis\Git\rysis-atrax2\" }
function atraxApi { cd "D:\Rysis\Git\rysis-atrax2\Operational System\Atrax.Api" }
function atraxWeb { cd "D:\Rysis\Git\rysis-atrax2\Operational System\Atrax.Webapp\ClientApp\" }
function atraxSql { cd "D:\Rysis\Git\rysis-atrax2\Operational System\Atrax.Midtier\SqlProxyClassGen\" }

### EXEC MOBILE
function exec { cd "D:\Rysis\Git\rysis-execmobile\ExecMobile" }
function execApi { cd "D:\Rysis\Git\rysis-execmobile\ExecMobile\ExecMobile.Api" }
function execWeb { cd "D:\Rysis\Git\rysis-execmobile\ExecMobile\ExecMobile.Web\ClientApp" }
function execSql { cd "D:\Rysis\Git\rysis-execmobile\ExecMobile\ExecMobile.Sql\SqlScripts" }

### PRESS COUNCIL
function press { cd "D:\Rysis\Git\rysis-pressombudsman\" }
function pressSql { cd "D:\Rysis\Git\rysis-pressombudsman\PressOmbudsman.Midtier\Bat2\" }

### PERSONAL DIR
function omoiDev { cd "C:\Users\nhlan\Desktop\Development" }
function omoiGit { cd "C:\Users\nhlan\Desktop\Development\Git" }
function omoiSite { cd "C:\Users\nhlan\Desktop\Development\Git\portfolio" }

### STARSHIP THEME
function star { Invoke-Expression (&starship init powershell) }
