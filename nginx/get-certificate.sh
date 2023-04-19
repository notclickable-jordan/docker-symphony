#!/bin/bash

subdomain="wallabag"

docker run --rm -it \
    --entrypoint="" \
    -v letsencrypt:/etc/letsencrypt \
    -v certbot:/var/www/certbot \
    -e TERM=xterm \
    certbot/certbot:v2.4.0 \
    sh -c "certbot certonly --reinstall -n -v -d ${subdomain}.starbase80.dev --cert-name ${subdomain}.starbase80.dev --webroot --webroot-path /var/www/certbot/ --agree-tos --email jordan@notclickable.com"
