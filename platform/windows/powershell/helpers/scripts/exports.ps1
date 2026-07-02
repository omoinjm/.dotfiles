# Import scripts
$export_path = "$env:USERPROFILE\.config\powershell\helpers\scripts"

Import-Module -Name "$export_path\azure\azure_env_settings.ps1"
Import-Module -Name "$export_path\azure\export_az_users.ps1"
Import-Module -Name "$export_path\azure\azure_connect.ps1" 
Import-Module -Name "$export_path\webhooks\curl_discord.ps1"
Import-Module -Name "$export_path\functions\update.ps1"
Import-Module -Name "$export_path\functions\git.ps1"
Import-Module -Name "$export_path\functions\bash.ps1"
# Import-Module -Name "$export_path\env\p_env.ps1"
# Import-Module -Name "$export_path\env\rysis_env.ps1"
Import-Module -Name "$export_path\startup\main.ps1"
