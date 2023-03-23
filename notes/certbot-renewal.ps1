# Run the letsencript container to renew the certificate
docker compose run --rm letsencrypt

# Reload nginx on this container group
docker exec trilium_nginx nginx -s reload

# As well as the main switchboard container group
cd ../nginx
docker exec switchboard nginx -s reload