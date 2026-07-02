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
$env:STARSHIP_CONFIG = "$env:USERPROFILE\.config\starship\json.toml"


function Invoke-Starship-TransientFunction {
    &starship module character
}

Invoke-Expression (&starship init powershell)

Enable-TransientPrompt
