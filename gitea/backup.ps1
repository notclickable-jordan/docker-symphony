# Set variables
$File1 = "gitea-data.tgz"
$File2 = "gitea-db.tgz"
$File3 = "gitea-woodpecker.tgz";

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from gitea_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar -C /data -cvzf /backup/${File1} . && `
    tar -C /var/lib/postgresql/data -cvzf /backup/${File2} . &&`
    tar -C /var/lib/woodpecker -cvzf /backup/${File3} ."

# Copy to external drive and overwrite if files already exist
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force
Move-Item ".\${File2}" "${BackupFolder}\${dateString}\${File2}" -Force
Move-Item ".\${File3}" "${BackupFolder}\${dateString}\${File3}" -Force