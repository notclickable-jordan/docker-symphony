# Helpers and variables
Import-Module -Name ".\helpers.psm1"
$dateString = Get-Date -Format "yyyy-MM-dd"
$Image = "alpine:3.17.2"

# Create backup folder
$BackupFolder = "D:\Backup\Not Clickable\docker\"
Create-DatedDirectory -folderPath $BackupFolder

# Get all PowerShell scripts in subfolders
$scripts = Get-ChildItem -Path "." -Recurse -Include "backup.ps1"

# Loop through each script and execute it
foreach ($script in $scripts) {
    & $_.FullName
}

# Delete backups older than 7 days
Get-ChildItem -Path $BackupFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -Recurse