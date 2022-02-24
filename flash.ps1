
$fastboot = "platform-tools/fastboot.exe"
if (Test-Path -path $fastboot) {
    Write-Host 'Platform tools found';
} else {
    Write-Host 'Downloading platform tools';

    $client = new-object System.Net.WebClient
    $client.DownloadFile("https://dl.google.com/android/repository/platform-tools_r28.0.2-windows.zip", "platform-tools.zip")

    Write-Host 'Extracting platform tools';
    Expand-Archive -Path "platform-tools.zip" -DestinationPath "." -Force

    Remove-Item "platform-tools.zip"
}

Write-Host 'Extracting NEOS...';
Expand-Archive -Path "ota-signed-juiceme-kernel.zip" -DestinationPath "." -Force


Invoke-Expression "$($fastboot) flash recovery recovery.img"
Invoke-Expression "$($fastboot) flash boot files/boot.img"

Invoke-Expression "$($fastboot) reboot"


Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
