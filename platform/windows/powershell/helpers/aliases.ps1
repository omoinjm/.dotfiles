# Alias
Set-Alias ll ls
Set-Alias g git
Set-Alias -Name idea -Value "C:\Program Files\JetBrains\IntelliJ IDEA 2023.2.1\bin\idea64.exe" 
Set-Alias grep findstr
Set-Alias -Name vim nvim
Set-Alias -Name vi nvim
Set-Alias -Name eth -Value Get-NetAdapter
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"
# Set-Alias -Name curl -Value "C:\Program Files\Git\mingw64\bin\curl.exe" -Option AllScope
Set-Alias -Name iis -Value "C:\Program Files\IIS Express\iisexpress.exe" -Option AllScope
Set-Alias -Name openvpn -Value "C:\Program Files\OpenVPN\bin\openvpn.exe" -Option AllScope
Set-Alias -Name cl -Value "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.36.32532\bin\Hostx64\x64\cl.exe"
# Set-Alias -Name touch -Value "C:\Program Files\Git\usr\bin\touch.exe" -Option AllScope
Set-Alias -Name java -Value "C:\Users\nhlan\.jdks\ms-17.0.15\bin\java.exe"

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

