. $HOME\.config\powershell\helpers\functions\git.ps1

# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias idea idea64
Set-Alias -Name eth -Value Get-NetAdapter
Set-Alias -Name Pywal-Starship -Value pywal_to_starship
Set-Alias -Name Wallpaper-Starship -Value update_pywal_to_starship
Set-Alias -Name Screenshot-Starship -Value screenshot_to_pywal_to_starship
Set-Alias -Name vim nvim
Set-Alias -Name curl -Value "C:\Program Files\Git\mingw64\bin\curl.exe" -Option AllScope


# Utilities

## Find program location
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

## Find any file in the system
function find-file($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        $place_path = $_.directory
        Write-Output "${place_path}\${_}"
    }
}

