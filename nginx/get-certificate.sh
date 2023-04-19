#!/bin/bash

subdomain="wallabag"

docker run --rm \
    -v letsencrypt:/etc/letsencrypt \
    -v certbot:/var/www/certbot \
    certbot/certbot:v2.4.0 \
    certonly --reinstall -n -v \
    -d ${subdomain}.starbase80.dev \
    --cert-name ${subdomain}.starbase80.dev \
    --webroot --webroot-path /var/www/certbot/ --agree-tos --email jordan@notclickable.com