# Set up process

Profile directory

```powershell
. $env:dotfiles\powershell\user_profile.ps1
```

1. Install Terminal Icons

```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
```

2. Install fuzzy finder

```powershell
Install-Module -Name PSFzf -Scope CurrentUser -Force

scoop install fzf
```

3. Install Intellisence

```powershell
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
```

4. Install Oh My Posh

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
