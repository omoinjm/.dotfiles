# Set up process

1. Install Terminal Icons
  
  - Install-Module -Name Terminal-Icons -Repository PSGallery -Force

2. Install fuzzy finder

  - Install-Module -Name PSFzf -Scope CurrentUser -Force

3. Install Intellisence

  - Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

  - Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
