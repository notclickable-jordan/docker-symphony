# Set variables
$File1 = "vscode-config.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from vscode_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar cvzf /backup/${File1} /data"

# Copy to external drive and overwrite if files already exist
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force