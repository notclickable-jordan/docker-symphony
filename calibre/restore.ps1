# Variables
$File1 = "calibre-config.tar.gz"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d
docker compose down

# Restore the volume data from the backups
docker run --rm `
    -v ${pwd}/${File1}:/backup/${File1} `
    -v calibre_config:/restore/calibre_config `
    alpine sh -c `
        "tar -xvzf /backup/${File1} -C /restore/calibre_config"

# Restore the site with the data
docker compose up -d