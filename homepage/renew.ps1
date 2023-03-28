docker compose run --rm letsencrypt
docker exec homepage_nginx nginx -s reload
cd ../nginx
docker exec switchboard nginx -s reload