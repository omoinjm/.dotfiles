# Icons
Import-Module -Name Terminal-Icons

# Get script directory
 function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }

# Load prompt config
function posh {
    # Join path to the prompt config
    # $PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'config\json.omp.json'
    $PROMPT_CONFIG = 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/json.omp.json'

    # Initialize oh-my-posh with the specified config
    oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression
}

if ($PSVersionTable.PSVersion.Major -ge 7) {
  # PSReadLine
  Set-PSReadLineOption -EditMode Emacs
  Set-PSReadLineOption -BellStyle None
  Set-PSReadLineOption -PredictionSource History
  Set-PSReadLineOption -PredictionViewStyle ListView 
  Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
}

# Fzf
Set-PSReadLineKeyHandler -Key 'Ctrl+r' -ScriptBlock { fzf }

# STARSHIP THEME
$env:STARSHIP_DISTRO = "者 omoi "
$env:STARSHIP_CONFIG = "$env:USERPROFILE\.config\starship\tokyonight_storm.toml"

function Register-WslGitSafeDirectory {
    $top = git rev-parse --show-toplevel 2>$null
    if (-not $top -or $top -notmatch '^//wsl\.') { return }

    # Git for Windows expects: %(prefix)///wsl.localhost/Distro/...
    $entry = '%(prefix)/' + $top
    $existing = @(git config --global --get-all safe.directory 2>$null)
    if ($existing -notcontains $entry) {
        git config --global --add safe.directory $entry | Out-Null
    }
}

Register-WslGitSafeDirectory

function Invoke-Starship-TransientFunction {
    &starship module character
}

Invoke-Expression (&starship init powershell)
# Invoke-Expression (&posh init powershell)

$script:StarshipPrompt = Get-Command prompt -CommandType Function
function global:prompt {
    Register-WslGitSafeDirectory
    & $script:StarshipPrompt.ScriptBlock
}

Enable-TransientPrompt
