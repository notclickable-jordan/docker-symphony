# Variables
$File1 = "gitea-data.tgz"
$Volume1 = "gitea_data"
$Folder1 = "/restore/${Volume1}}"
$File2 = "gitea-db.tgz"
$Volume2 = "gitea_db"
$Folder2 = "/restore/${Volume1}}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d
docker compose down

# Restore the volume data from the backups
docker run --rm `
    -v ${pwd}/${File1}:/backup/${File1} `
    -v ${Volume1}:${Folder1} `
    alpine:3.17.2 sh -c `
        "tar -xvzf /backup/${File1} -C ${Folder1} && `
        tar -xvzf /backup/${File2} -C ${Folder2}"

# Restore the site with the data
docker compose up -d