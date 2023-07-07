Import-Module -Name "$env:dotfiles\powershell\helpers\env\driverisk.ps1"

# Environment variables
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"
$env:STARSHIP_CONFIG = "$env:dotfiles\.starship\starship.toml"
$env:STARSHIP_DISTRO = "者 omoi "