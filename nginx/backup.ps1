# Set variables
$File1 = "nginx-certbot.tgz"
$File2 = "nginx-grafana.tgz"
$File3 = "nginx-letsencrypt.tgz"
$File4 = "nginx-logs.tgz"
$File5 = "nginx-loki.tgz"
$File6 = "nginx-prometheus.tgz"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from switchboard_backup `
    -v ${pwd}:/backup ${Image} sh -c `
    "tar -C /var/www/certbot -cvzf /backup/${File1} . && `
    tar -C /var/lib/grafana -cvzf /backup/${File2} . && `
    tar -C /etc/letsencrypt -cvzf /backup/${File3} . && `
    tar -C /var/log/nginx -cvzf /backup/${File4} . && `
    tar -C /loki -cvzf /backup/${File5} . && `
    tar -C /prometheus -cvzf /backup/${File6} ."

# Copy to external drive and overwrite if files already exist
Move-Item ".\${File1}" "${BackupFolder}\${dateString}\${File1}" -Force
Move-Item ".\${File2}" "${BackupFolder}\${dateString}\${File2}" -Force
Move-Item ".\${File3}" "${BackupFolder}\${dateString}\${File3}" -Force
Move-Item ".\${File4}" "${BackupFolder}\${dateString}\${File4}" -Force
Move-Item ".\${File5}" "${BackupFolder}\${dateString}\${File5}" -Force
Move-Item ".\${File6}" "${BackupFolder}\${dateString}\${File6}" -Force