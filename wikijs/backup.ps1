# Set variables
$File1 = "wikijs-data.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from wikijs_db_data `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar cvzf /backup/${File1} /var/lib/postgresql/data"

# Copy to external drive and overwrite if files already exist
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force