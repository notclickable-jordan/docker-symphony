# Helpers and variables
Import-Module -Name ".\helpers.psm1"
$dateString = Get-Date -Format "yyyy-MM-dd"
$Image = "alpine:3.17.2"

# Create backup folder
$BackupFolder = "D:\Backup\Not Clickable\docker\"
Create-DatedDirectory -folderPath $BackupFolder

# Run all backup scripts
& "$PSScriptRoot/archivebox/backup.ps1"
& "$PSScriptRoot/calibre/backup.ps1"
& "$PSScriptRoot/gitea/backup.ps1"
& "$PSScriptRoot/mastodon/backup.ps1"
& "$PSScriptRoot/mealie/backup.ps1"
& "$PSScriptRoot/minecraft/backup.ps1"
& "$PSScriptRoot/miniflux/backup.ps1"
& "$PSScriptRoot/vaultwarden/backup.ps1"
& "$PSScriptRoot/vscode/backup.ps1"
& "$PSScriptRoot/wikijs/backup.ps1"

# Delete backups older than 7 days
Get-ChildItem -Path $BackupFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -Recurse