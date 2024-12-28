# Set up process

Profile directory

```powershell
# Create symlink that points to wsl
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.config" -Target "\\wsl.localhost\Ubuntu-24.04\<path>"

. $env:USERPROFILE\.config\powershell\user_profile.ps1

# Import the Chocolatey Profile that contains the necessary code to enable.
# Tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# For `choco` will not function.
# See https://ch0.co/tab-completion for details.

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
   Import-Module "$ChocolateyProfile"
}
```

## 1. Install Terminal Icons

```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
```

## 2. Install fuzzy finder

```powershell
Install-Module -Name PSFzf -Scope CurrentUser -Force

scoop install fzf
```

## 3. Install Intellisence

```powershell
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
```

## 4. Install Oh My Posh

```powershell
Install-Module -Name posh-git -Force

winget install oh-my-posh --source winget
```

Other / Helpful packages

```powershell
Install-Module -Name AzureAD -Force

Install-Module -Name NuGet -Force

Install-Module -Name Microsoft.Graph.Users -Force

sudo Install-Module -Name Microsoft.Graph.Authentication -Force
```
