# Variables
$File1 = "mastodon-web.tgz"
$Volume1 = "mastodon_web"
$Folder1 = "/restore/${Volume1}}"

$File2 = "mastodon-redis.tgz"
$Volume2 = "mastodon_redis"
$Folder2 = "/restore/${Volume2}"

$File3 = "mastodon-db.tgz"
$Volume3 = "mastodon_db"
$Folder3 = "/restore/${Volume3}}"

$File4 = "mastodon-letsencrypt.tgz"
$Volume4 = "mastodon_letsencrypt"
$Folder4 = "/restore/${Volume4}}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d
docker compose down

# Restore the volume data from the backups
docker run --rm `
    -v ${pwd}/${File1}:/backup/${File1} `
    -v ${pwd}/${File2}:/backup/${File2} `
    -v ${pwd}/${File3}:/backup/${File3} `
    -v ${pwd}/${File4}:/backup/${File4} `
    -v ${Volume1}:${Folder1} `
    -v ${Volume2}:${Folder2} `
    -v ${Volume3}:${Folder3} `
    -v ${Volume4}:${Folder4} `
    -v ${Volume5}:${Folder5} `
    alpine:3.17.2 sh -c `
        "tar -xvzf /backup/${File1} -C ${Folder1} && `
        tar -xvzf /backup/${File2} -C ${Folder2} && `
        tar -xvzf /backup/${File3} -C ${Folder3} && `
        tar -xvzf /backup/${File4} -C ${Folder4}"

# Restore the site with the data
docker compose up -d