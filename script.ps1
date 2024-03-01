$connectTestResult = Test-NetConnection -ComputerName visibillfiles.file.core.windows.net -Port 445

if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"visibillfiles.file.core.windows.net`" /user:`"localhost\visibillfiles`" /pass:`"68CaPTBanmu+vIxj1pV4JtnrxKAiRQF17cadaSzXtZnto+wLo2Xz15UGBCzlQv4k92d103Xhl3x+AStxCILYw==`""
    # Mount the drive
    New-PSDrive -Name L -PSProvider FileSystem -Root "\\visibillfiles.file.core.windows.net\visibillfiles" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}
