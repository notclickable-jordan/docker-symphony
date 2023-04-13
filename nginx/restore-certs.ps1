# Variables
$File1 = "homepage-letsencrypt.tgz"
$File2 = "mastodon-letsencrypt.tgz"
$File3 = "vaultwarden-letsencrypt.tgz"
$VolumeName = "letsencrypt"
$FolderName = "/restore/${VolumeName}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d --build backup
docker compose down

# Restore the volume data from the backups
docker run --rm `
    -v ${pwd}/${File1}:/backup/${File1} `
    -v ${pwd}/${File2}:/backup/${File2} `
    -v ${pwd}/${File3}:/backup/${File3} `
    -v ${VolumeName}:${FolderName} `
    alpine:3.17.2 sh -c `
        "tar -xvzf /backup/${File1} -C ${FolderName} && `
        tar -xvzf /backup/${File2} -C ${FolderName} && `
        tar -xvzf /backup/${File3} -C ${FolderName}"

# Restore the site with the data
docker compose up -d