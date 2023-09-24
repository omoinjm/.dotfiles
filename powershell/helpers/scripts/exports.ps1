# Import scripts
$export_path = "$env:dotfiles\powershell\helpers\scripts"

Import-Module -Name "$export_path\azure\azure_env_settings.ps1"
Import-Module -Name "$export_path\azure\export_az_users.ps1"
Import-Module -Name "$export_path\azure\azure_connect.ps1" 
Import-Module -Name "$export_path\webhooks\curl_discord.ps1"
Import-Module -Name "$export_path\functions\update.ps1"
Import-Module -Name "$export_path\functions\git.ps1"
Import-Module -Name "$export_path\functions\bash.ps1"
