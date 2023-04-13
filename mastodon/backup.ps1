# Set variables
$File1 = "mastodon-web.tgz"
$File2 = "mastodon-redis.tgz"
$File3 = "mastodon-db.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from mastodon_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar -C /mastodon/public/system -cvzf /backup/${File1} . && `
    tar -C /data -cvzf /backup/${File2} . && `
    tar -C /var/lib/postgresql/data -cvzf /backup/${File3} ."

# Copy to external drive and overwrite if files already exist
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force
Move-Item ".\${File2}" "${BackupFolder}\${dateString}\${File2}" -Force
Move-Item ".\${File3}" "${BackupFolder}\${dateString}\${File3}" -Force