Write-Host 'Downloading MSI package'
$msi_url = "https://www.7-zip.org/a/7z1801-x64.msi"
$msi_file = "C:/7z1801-x64.msi"
(New-Object System.Net.WebClient).DownloadFile($msi_url, $msi_file)

Write-Host 'Installing MSI package'
Start-Process msiexec.exe -Wait -ArgumentList "/I $msi_file /quiet"
# Start-Process msiexec.exe -Wait -ArgumentList '/I C:\synced_folder\7z1801-x64.msi /quiet'
