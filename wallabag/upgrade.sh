# Upgrade database if unable to login
docker exec -t wallabag /var/www/wallabag/bin/console doctrine:migrations:migrate --env=prod --no-interaction