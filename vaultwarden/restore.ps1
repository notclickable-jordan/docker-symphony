# Variables
$File1 = "vaultwarden-data.tgz"
$Volume1 = "vaultwarden_data"
$Folder1 = "/restore/${Volume1}}"

$File2 = "vaultwarden-letsencrypt.tgz"
$Volume2 = "vaultwarden_letsencrypt"
$Folder2 = "/restore/${Volume2}}"

$File3 = "vaultwarden-letsencrypt_lib.tgz"
$Volume3 = "vaultwarden_letsencrypt_lib"
$Folder3 = "/restore/${Volume3}}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d
docker compose down

# Restore the volume data from the backups
docker run --rm `
    -v ${pwd}/${File1}:/backup/${File1} `
    -v ${pwd}/${File2}:/backup/${File3} `
    -v ${pwd}/${File3}:/backup/${File2} `
    -v ${Volume1}:${Folder1} `
    -v ${Volume2}:${Folder2} `
    -v ${Volume3}:${Folder3} `
    alpine:3.17.2 sh -c `
        "tar -xvzf /backup/${File1} -C ${Folder1} && `
        tar -xvzf /backup/${File2} -C ${Folder2} && `
        tar -xvzf /backup/${File3} -C ${Folder3}"

# Restore the site with the data
docker compose up -d