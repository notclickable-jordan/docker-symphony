# Set variables
$BackupFolder = "D:\Backup\Not Clickable\docker\vaultwarden"
$File1 = "backup-vaultwarden-data.tgz"
$File2 = "backup-letsencrypt-letsencrypt.tgz"
$File3 = "backup-letsencrypt-letsencrypt_lib.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from vaultwarden_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar cvzf /backup/${File1} /data && `
    tar cvzf /backup/${File2} /etc/letsencrypt && `
    tar cvzf /backup/${File3} /var/lib/letsencrypt"

# Copy to external drive and overwrite if files already exist
Create-DatedDirectory -folderPath $BackupFolder
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force
Move-Item ".\${File2}" "${BackupFolder}\${dateString}\${File2}" -Force
Move-Item ".\${File3}" "${BackupFolder}\${dateString}\${File3}" -Force

# Delete backups older than 7 days
Get-ChildItem -Path $BackupFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -Recurse