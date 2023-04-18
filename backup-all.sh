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
export dateString=$(date +"%Y-%m-%d")
export Image="alpine:3.17.2"

# Create backup folder
export BackupFolder="/mnt/synology/home/Backup/docker-symphony"
Create-DatedDirectory "$BackupFolder"

# Run all backup scripts
"./archivebox/backup.sh"
"./calibre/backup.sh"
"./gitea/backup.sh"
"./jellyfin/backup.sh"
"./mastodon/backup.sh"
"./mealie/backup.sh"
"./miniflux/backup.sh"
"./nginx/backup.sh"
"./n8n/backup.sh"
"./rohertwins/backup.sh"
"./roherwiki/backup.sh"
"./vaultwarden/backup.sh"
"./vscode/backup.sh"

# Delete backups older than 7 days
find "$BackupFolder" -type d -mtime +7 -exec rm -rf {} \;
rm *.tgz