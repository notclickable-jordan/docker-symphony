# Set variables
$BackupFolder = "D:\Backup\Not Clickable\docker\gitea"
$File1 = "backup-gitea-data.tgz"
$File2 = "backup-gitea-db.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from mastodon_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar cvzf /backup/${File1} /data && `
    tar cvzf /backup/${File2} /var/lib/postgresql/data"

# Copy to external drive and overwrite if files already exist
Create-DatedDirectory -folderPath $BackupFolder
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force
Move-Item ".\${File2}" "${BackupFolder}\${dateString}\${File2}" -Force

# Delete backups older than 7 days
Get-ChildItem -Path $BackupFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -Recurse