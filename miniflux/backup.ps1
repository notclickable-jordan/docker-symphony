# Static
Import-Module -Name "..\helpers.psm1"
$dateString = Get-Date -Format "yyyy-MM-dd"
$Image = "alpine:3.17.2"

# Set variables
$BackupFolder = "D:\Backup\Not Clickable\docker\miniflux"
$File1 = "backup-miniflux-db.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from calibre_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar cvzf /backup/${File1} /var/lib/postgresql/data"

# Copy to external drive and overwrite if files already exist
Create-DatedDirectory -folderPath $BackupFolder
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force

# Delete backups older than 7 days
Get-ChildItem -Path $BackupFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -Recurse