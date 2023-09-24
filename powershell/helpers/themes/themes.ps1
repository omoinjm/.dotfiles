# Prompt
# oh-my-posh init pwsh | Invoke-Expression

# Load prompt config
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'config\json.omp.json'

function posh {
    oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression
}

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView 
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar

# Fzf
Set-PSReadLineKeyHandler -Key 'Ctrl+r' -ScriptBlock { fzf }

# STARSHIP THEME
$env:STARSHIP_DISTRO = "者 omoi "
$env:STARSHIP_CONFIG = "$env:dotfiles\.starship\json.toml"

function Invoke-Starship-TransientFunction {
    &starship module character
}
  
Invoke-Expression (&starship init powershell)
  
Enable-TransientPrompt
