# Set up process

Profile directory

```powershell
. $HOME\.config\powershell\user_profile.ps1
```

1. Install Terminal Icons

```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
```

2. Install fuzzy finder

```powershell
Install-Module -Name PSFzf -Scope CurrentUser -Force
```

3. Install Intellisence

```powershell
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
```

Other / Helpful packages

```powershell
Install-Module -Name posh-git -Force

 Install-Module -Name AzureAD -Force

Install-Module -Name NuGet -Force

Install-Module -Name Microsoft.Graph.Users -Force

sudo Install-Module -Name Microsoft.Graph.Authentication -Force

```
