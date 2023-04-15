# Set variables
$File1 = "rohertwins-content.tgz"
$File2 = "rohertwins-db.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from rohertwins_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar -C /var/lib/ghost/content -cvzf /backup/${File1} . && `
    tar -C /var/lib/mysql -cvzf /backup/${File2} ."

# Copy to external drive and overwrite if files already exist
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force
Move-Item ".\${File2}" "${BackupFolder}\${dateString}\${File2}" -Force