# Nuget package imports
# Import-Module NuGet
# Import-Module AzureAD
# Import-Module PackageManagement
# Import-Module Microsoft.Graph
# Import-Module Microsoft.Graph.Users
# Import-Module Microsoft.Graph.Authentication 

Set-Variable -Name path -Value "$env:dotfiles\powershell\helpers" -Option Constant

# Scripts and programs
Import-Module -Name "$path\scripts\exports.ps1"

# Command line themes
Import-Module -Name "$path\themes\themes.ps1"

# Directories
Import-Module -Name "$path\directories\dirs.ps1"
Import-Module -Name "$path\directories\p_dirs.ps1"

# Function commands
Import-Module -Name "$path\aliases.ps1"
