# Set variables
$File1 = "homepage-letsencrypt.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from homepage_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar -C /etc/letsencrypt -cvzf /backup/${File1} ."

# Copy to external drive and overwrite if files already exist
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force