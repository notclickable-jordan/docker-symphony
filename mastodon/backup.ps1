# Static
Import-Module -Name "..\helpers.psm1"
$dateString = Get-Date -Format "yyyy-MM-dd"
$Image = "alpine:3.17.2"

# Set variables
$BackupFolder = "D:\Backup\Not Clickable\docker\mastodon"
$File1 = "backup-mastodon-web.tgz"
$File2 = "backup-redis-redis.tgz"
$File3 = "backup-db-db.tgz"
$File4 = "backup-letsencrypt-letsencrypt.tgz"
$File5 = "backup-letsencrypt-letsencrypt_lib.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from mastodon_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar cvzf /backup/${File1} /mastodon/public/system && `
    tar cvzf /backup/${File2} /data && `
    tar cvzf /backup/${File3} /var/lib/postgresql/data && `
    tar cvzf /backup/${File4} /etc/letsencrypt && `
    tar cvzf /backup/${File5} /var/lib/letsencrypt"

# Copy to external drive and overwrite if files already exist
Create-DatedDirectory -folderPath $BackupFolder
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force
Move-Item ".\${File2}" "${BackupFolder}\${dateString}\${File2}" -Force
Move-Item ".\${File3}" "${BackupFolder}\${dateString}\${File3}" -Force
Move-Item ".\${File4}" "${BackupFolder}\${dateString}\${File4}" -Force
Move-Item ".\${File5}" "${BackupFolder}\${dateString}\${File5}" -Force

# Delete backups older than 7 days
Get-ChildItem -Path $BackupFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force