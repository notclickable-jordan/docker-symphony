cd mastodon
docker compose run --rm letsencrypt
docker exec mastodon_nginx nginx -s reload
cd ../nginx
docker exec switchboard nginx -s reload
cd ..