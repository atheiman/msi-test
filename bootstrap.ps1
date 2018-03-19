$msi_url = "https://www.7-zip.org/a/7z1801-x64.msi"
$msi_file = "C:\7z1801-x64.msi"

Write-Host "Downloading MSI package from $msi_url to $msi_file"
(New-Object System.Net.WebClient).DownloadFile($msi_url, $msi_file)

Write-Host "Installing MSI package from $msi_file"
Start-Process msiexec.exe -Wait -ArgumentList "/I $msi_file /quiet"
