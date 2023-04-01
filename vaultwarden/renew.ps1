cd vaultwarden
docker compose run --rm letsencrypt
docker exec vaultwarden_nginx nginx -s reload
cd ../nginx
docker exec switchboard nginx -s reload
cd ..