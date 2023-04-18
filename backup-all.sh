#!/bin/bash

# Untested

# Helper
function Create-DatedDirectory {
    folderPath="$1"

    # Get the current date and format it as YYYY-MM-DD
    dateString=$(date +"%Y-%m-%d")

    # Combine the folder path and date string to create the directory path
    directoryPath="$folderPath/$dateString"

    # Check if the directory already exists, if not, create it
    if [ ! -d "$directoryPath" ]; then
        mkdir "$directoryPath"
    fi
}

# Variables
dateString=$(date +"%Y-%m-%d")
Image="alpine:3.17.2"

# Create backup folder
BackupFolder="/mnt/synology/home/Backup/docker-symphony"
Create-DatedDirectory "$BackupFolder"

# Run all backup scripts
"$PSScriptRoot/archivebox/backup.ps1"
"$PSScriptRoot/calibre/backup.ps1"
"$PSScriptRoot/gitea/backup.ps1"
"$PSScriptRoot/jellyfin/backup.ps1"
"$PSScriptRoot/mastodon/backup.ps1"
"$PSScriptRoot/mealie/backup.ps1"
"$PSScriptRoot/miniflux/backup.ps1"
"$PSScriptRoot/nginx/backup.ps1"
"$PSScriptRoot/n8n/backup.ps1"
"$PSScriptRoot/rohertwins/backup.ps1"
"$PSScriptRoot/vaultwarden/backup.ps1"
"$PSScriptRoot/vscode/backup.ps1"
"$PSScriptRoot/wikijs/backup.ps1"

# Delete backups older than 7 days
find "$BackupFolder" -type d -mtime +7 -exec rm -rf {} \;
