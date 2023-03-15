# CAUTION: DOES NOT WORK
# Something is wrong with where letsencrypt-letsencrypt.tar.gz restores the /etc/letsencrypt/live folder.
# Instead of going in /etc/letsencrypt, it goes in /etc/letsencrypt/etc/letsencrypt/live
# DO NOT USE UNTIL THIS IS FIXED

# Variables
$File1 = "backup-calibre-config.tar.gz"
$File2 = "backup-letsencrypt-letsencrypt.tar.gz"
$File3 = "backup-letsencrypt-letsencrypt_lib.tar.gz"

# Bring down the existing site
docker compose down

# Remove and recreate the volumes
docker volume rm calibre_config
docker volume rm calibre_letsencrypt
docker volume rm calibre_letsencrypt_lib

# Bring up the containers to create the volumes
docker compose up -d
docker compose down

# Restore the volume data from the backups
docker run --rm `
    -v ${pwd}/${File1}:/backup/${File1} `
    -v ${pwd}/${File2}:/backup/${File2} `
    -v ${pwd}/${File3}:/backup/${File3} `
    -v calibre_config:/restore/calibre_config `
    -v calibre_letsencrypt:/restore/calibre_letsencrypt `
    -v calibre_letsencrypt_lib:/restore/calibre_letsencrypt_lib `
    alpine sh -c `
        "tar -xvzf /backup/${File1} -C /restore/calibre_config && `
        tar -xvzf /backup/${File2} -C /restore/calibre_letsencrypt && `
        tar -xvzf /backup/${File3} -C /restore/calibre_letsencrypt_lib"

# Restore the site with the data
docker compose up -d