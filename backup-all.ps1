# Helper
function Create-DatedDirectory {
    param(
        [Parameter(Mandatory=$true)]
        [string]$folderPath
    )

    # Get the current date and format it as YYYY-MM-DD
    $dateString = Get-Date -Format "yyyy-MM-dd"

    # Combine the folder path and date string to create the directory path
    $directoryPath = Join-Path -Path $folderPath -ChildPath $dateString

    # Check if the directory already exists, if not, create it
    if (-not (Test-Path -Path $directoryPath -PathType Container)) {
        New-Item -ItemType Directory -Path $directoryPath
    }
}

# Variables
$dateString = Get-Date -Format "yyyy-MM-dd"
$Image = "alpine:3.17.2"

# Create backup folder
$BackupFolder = "H:\Backup\docker-symphony"
Create-DatedDirectory -folderPath $BackupFolder

# Run all backup scripts
& "$PSScriptRoot/archivebox/backup.ps1"
& "$PSScriptRoot/calibre/backup.ps1"
& "$PSScriptRoot/gitea/backup.ps1"
& "$PSScriptRoot/homepage/backup.ps1"
& "$PSScriptRoot/mastodon/backup.ps1"
& "$PSScriptRoot/mealie/backup.ps1"
& "$PSScriptRoot/minecraft/backup.ps1"
& "$PSScriptRoot/miniflux/backup.ps1"
& "$PSScriptRoot/vaultwarden/backup.ps1"
& "$PSScriptRoot/vscode/backup.ps1"
& "$PSScriptRoot/wikijs/backup.ps1"

# Delete backups older than 7 days
Get-ChildItem -Path $BackupFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -Recurse