docker compose run --rm letsencrypt
docker exec miniflux_nginx nginx -s reload
cd ../nginx
docker exec switchboard nginx -s reload