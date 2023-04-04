# Set variables
$File1 = "mastodon-web.tgz"
$File2 = "mastodon-redis.tgz"
$File3 = "mastodon-db.tgz"
$File4 = "mastodon-letsencrypt.tgz"
$File5 = "mastodon-letsencrypt_lib.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from mastodon_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar cvzf /backup/${File1} /mastodon/public/system && `
    tar cvzf /backup/${File2} /data && `
    tar cvzf /backup/${File3} /var/lib/postgresql/data && `
    tar cvzf /backup/${File4} /etc/letsencrypt && `
    tar cvzf /backup/${File5} /var/lib/letsencrypt"

# Copy to external drive and overwrite if files already exist
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force
Move-Item ".\${File2}" "${BackupFolder}\${dateString}\${File2}" -Force
Move-Item ".\${File3}" "${BackupFolder}\${dateString}\${File3}" -Force
Move-Item ".\${File4}" "${BackupFolder}\${dateString}\${File4}" -Force
Move-Item ".\${File5}" "${BackupFolder}\${dateString}\${File5}" -Force