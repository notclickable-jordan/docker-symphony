#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

# Log file path
LOG_FILE="/home/jordan/cron/backup-all.log"

# Truncate log file to 1 megabyte
truncate -s 1M "$LOG_FILE"

# Redirect stdout and stderr to the log file
exec &> >(tee -a "$LOG_FILE")

echo "backup-all.sh: $(date)"

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
export BackupFolder="/mnt/synology/home/docker-symphony"
Create-DatedDirectory "$BackupFolder"

# Run all backup scripts
"/home/jordan/docker-symphony/calibre/backup.sh"
"/home/jordan/docker-symphony/filegator/backup.sh"
"/home/jordan/docker-symphony/gitea/backup.sh"
"/home/jordan/docker-symphony/jellyfin/backup.sh"
"/home/jordan/docker-symphony/mastodon/backup.sh"
"/home/jordan/docker-symphony/mealie/backup.sh"
"/home/jordan/docker-symphony/miniflux/backup.sh"
"/home/jordan/docker-symphony/n8n/backup.sh"
"/home/jordan/docker-symphony/nginx/backup.sh"
"/home/jordan/docker-symphony/outline/backup.sh"
"/home/jordan/docker-symphony/rohertwins/backup.sh"
"/home/jordan/docker-symphony/standardnotes/backup.sh"
"/home/jordan/docker-symphony/vaultwarden/backup.sh"
"/home/jordan/docker-symphony/vscode/backup.sh"
"/home/jordan/docker-symphony/wallabag/backup.sh"

# Delete backups older than 7 days
find "$BackupFolder" -type d -mtime +7 -exec rm -rf {} \;

# Delete local backups
rm -rf *.tgz