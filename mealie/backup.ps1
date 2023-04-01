# Set variables
$BackupFolder = "D:\Backup\Not Clickable\docker\mealie"
$File1 = "backup-mealie-data.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from mealie_data `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar cvzf /backup/${File1} /app/data"

# Copy to external drive and overwrite if files already exist
Create-DatedDirectory -folderPath $BackupFolder
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force

# Delete backups older than 7 days
Get-ChildItem -Path $BackupFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -Recurse