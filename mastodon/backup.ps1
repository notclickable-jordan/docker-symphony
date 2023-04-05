# Set variables
$File1 = "mastodon-web.tgz"
$File2 = "mastodon-redis.tgz"
$File3 = "mastodon-db.tgz"
$File4 = "mastodon-letsencrypt.tgz"
$File5 = "mastodon-letsencrypt_lib.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from mastodon_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar -C /mastodon/public/system -cvzfp /backup/${File1} . && `
    tar -C /data -cvzfp /backup/${File2} . && `
    tar -C /var/lib/postgresql/data -cvzfp /backup/${File3} . && `
    tar -C /etc/letsencrypt -cvzfp /backup/${File4} . && `
    tar -C /var/lib/letsencrypt -cvzfp /backup/${File5} ."

# Copy to external drive and overwrite if files already exist
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force
Move-Item ".\${File2}" "${BackupFolder}\${dateString}\${File2}" -Force
Move-Item ".\${File3}" "${BackupFolder}\${dateString}\${File3}" -Force
Move-Item ".\${File4}" "${BackupFolder}\${dateString}\${File4}" -Force
Move-Item ".\${File5}" "${BackupFolder}\${dateString}\${File5}" -Force