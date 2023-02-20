# Nuget package imports
Import-Module AzureAD
Import-Module PackageManagement
Import-Module NuGet
Import-Module Microsoft.Graph.Users
# Import-Module Microsoft.Graph
Import-Module Microsoft.Graph.Authentication 
Import-Module PSFzf

## Prompt
Import-Module posh-git

## Icons
Import-Module Terminal-Icons

## scripts and programs
. $HOME\.config\powershell\helpers\scripts\Azure-Connect.ps1

## command line themes
. $HOME\.config\powershell\helpers\themes\themes.ps1

## directories
. $HOME\.config\powershell\helpers\dirs.ps1

## function commands
. $HOME\.config\powershell\helpers\aliases.ps1

## environment variables
. $HOME\.config\powershell\helpers\env.ps1
