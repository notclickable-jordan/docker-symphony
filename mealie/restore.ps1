# Variables
$File1 = "mealie-data.tgz"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d
docker compose down

# Restore the volume data from the backups
docker run --rm `
    -v ${pwd}/${File1}:/backup/${File1} `
    -v mealie_data:/restore/mealie_data `
    alpine sh -c `
        "tar -xvzf /backup/${File1} -C /restore/mealie_data"

# Restore the site with the data
docker compose up -d