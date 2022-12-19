# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# IMPORTS

## Prompt
Import-Module posh-git
oh-my-posh init pwsh | Invoke-Expression
# Set-PoshPrompt Paradox

## Icons
Import-Module Terminal-Icons

## Load prompt config
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'themes/json.omp.json'
oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionViewStyle ListView 
Set-PSReadLineOption -PredictionSource History

# Fzf
Import-Module PSFzf
Set-PsfzfOption -PSReadLineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"
$env:STARSHIP_CONFIG = "$HOME\.config\starship\ChristianLempa.toml"
$ENV:STARSHIP_DISTRO = "者 omoi"

# UPDATE SCRIPTS

function pywal_to_starship {
	Update-WalTerminal *>&1;
	bash ~/dev/winwaltostarship.sh;
	bash ~/dev/waltostarship.sh;
}

function update_pywal_to_starship{
	Update-WalTheme *>&1;
	bash ~/dev/winwaltostarship.sh;
	bash ~/dev/waltostarship.sh;
}

function screenshot_to_pywal_to_starship{
	Get-Wallpaper;
	pywal_to_starship;
}
