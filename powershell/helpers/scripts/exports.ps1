# Import scripts
$export_path = "$env:dotfiles\powershell\helpers\scripts"

Import-Module -Name "$export_path\azure_connect.ps1" 
Import-Module -Name "$export_path\azure_env_settings.ps1"
Import-Module -Name "$export_path\curl_discord.ps1"
Import-Module -Name "$export_path\export_az_users.ps1"
Import-Module -Name "$export_path\git.ps1"
