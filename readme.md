# About

Docker compose files for the services I run on my home server.

The main reverse proxy is in `/nginx` and handles ports 80 and 443. It proxies to the other services on their respective ports.

There are `env.*` files which you'll need to create if you want to replicate this setup. They contain environment variables for the services.

## Services

### TCP
- nginx (80, 443)
- Mastodon (8010-8013)
- Archivebox (8020)
- Jellyfin (8030)
- Calibre (8040)
- Miniflux (8050)
- WikiJS (8060)
- Grafana
    - nginx stub_status (8070)
    - Prometheus (8071)
    - Grafana (8072)
- MeTube (8080)
- Homepage (8090)
- Gitea (8100)
- Mealie (8110)
- Bookstack (8120)

### UDP
- Minecraft (19132)

# Discoveries

## Map network share to Docker volume

Run this independently in the command line, then mount the volume in the docker-compose.yml file as `external: true`

``` powershell
docker volume create --driver local --opt type=cifs --opt device=//ip.address/folder --opt o=user=username,password=password volume_name
```

It worked for me once, then I couldn't get it to work again.

## Obtaining a SSL certificate for an nginx Docker container

### Assumptions
- Container is called **my_app**
- App is on port 8080
- Domain is website.com
- There is a top level nginx reverse proxy service (**top_nginx**) sending traffic to **my_app**. If not, skip steps involving **top_nginx**.

### Steps
1. In **my_app**'s `docker-compose.yml`, add the following services and volumes
    ``` yaml
    services:
        my_app:
            ports: 8080:80

        nginx:
            image: nginx:1.23.3
            container_name: my_app_nginx
            volumes:
                - ./default.conf:/etc/nginx/conf.d/default.conf
                - letsencrypt:/etc/letsencrypt
                - certbot:/var/www/certbot
            ports:
                - 8081:80
                - 8082:443
            depends_on:
                - my_app
            restart: always

        letsencrypt:
            image: certbot/certbot:v2.4.0
            container_name: my_app_letsencrypt
            command: sh -c "certbot certonly --reinstall -v -d website.com --webroot --webroot-path /var/www/certbot/ --agree-tos --email me@website.com"
            entrypoint: ""
            depends_on:
                - nginx
            volumes:
                - letsencrypt:/etc/letsencrypt
                - certbot:/var/www/certbot
                - letsencrypt_lib:/var/lib/letsencrypt
            environment:
                - TERM=xterm

    volumes:
        certbot:
        letsencrypt:
        letsencrypt_lib:
    ```
1. Create a **my_app** `default.conf` file:
    ``` conf
    server {
        listen 80;
        server_name website.com;

        location ~ /.well-known/acme-challenge {
            allow all;
            root /var/www/certbot;
        }

        location / {
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Host $http_host;
            proxy_set_header X-NginX-Proxy true;

            proxy_pass http://host.docker.internal:8080;
        }
    }
    ```
1. Modify the **top_nginx** `conf.default` to point to the new HTTP port
    ``` conf
    # Instead of
    proxy_pass http://host.docker.internal:8080;

    # replace with
    proxy_pass http://host.docker.internal:8081;
    ```
1. Restart the **top_nginx** services
    ``` powershell
    cd ./top_nginx
    docker compose restart
    ```
1. Start and shutdown the **my_app** services to grab the certificate
    ``` powershell
    cd ./my_app
    docker compose up -d
    # In Docker Desktop, look at the letsencrypt container logs to see if the certificate was created
    docker compose down
    ```
1. Modify **my_app** `default.conf` to add a HTTPS redirect and add a HTTPS block
    ``` conf
    # Instead of
    proxy_pass http://host.docker.internal:8080;

    # replace with
    return 301 https://$host$request_uri;

    # Then add at the bottom of the file
    upstream backend {
        server host.docker.internal:8080;
    }

    server {
        listen 443 ssl http2;
        listen [::]:443 ssl http2;
        server_name website.com;

        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_ciphers HIGH:!MEDIUM:!LOW:!aNULL:!NULL:!SHA;
        ssl_prefer_server_ciphers on;
        ssl_session_cache shared:SSL:10m;
        ssl_session_tickets off;

        ssl_certificate /etc/letsencrypt/live/website.com/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/website.com/privkey.pem;

        location / {
            proxy_pass http://backend;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_redirect off;
        }
    }
    ```
1. Modify the top_nginx `docker-compose.yml` to use the main service's SSL certificates
    ``` yaml
    services:
        nginx:
            volumes:
                - my_app_letsencrypt:/etc/letsencrypt-my-app
    volumes:
        my_app_letsencrypt:
            external: true
    ```
1. In the **top_nginx** `default.conf` file, add the following block, keeping the existing HTTP one
    ``` conf
    server {
        listen 443 ssl;
        listen [::]:443 ssl;
        server_name example.com;

        ssl_certificate          /etc/letsencrypt-main-service/live/website.com/fullchain.pem;
        ssl_certificate_key      /etc/letsencrypt-main-service/live/website.com/privkey.pem;

        location / {
            proxy_set_header   X-Forwarded-For $remote_addr;
            proxy_set_header   Host $http_host;
            proxy_pass         https://host.docker.internal:8082;
        }
    }
    ```
1. Restart the **top_nginx** services
    ``` powershell
    cd ./top_nginx
    docker compose down
    docker compose up -d
    ```
1. Start the **main_service** services
    ``` powershell
    cd ./my_app # or whatever
    docker compose up -d
    ```

### Renewal

For a Windows host, here's how to create a script to renew the certificate and reload the nginx services.

1. In **my_app** `docker-compose.yml`, make sure the nginx service has a unique name:
    ``` yaml
    services:
        nginx:
            container_name: my_app_nginx
    ```
1. Create `certbot-renewal.ps1` in your my_app folder
    ``` powershell
    # Run the letsencript container to renew the certificate
    docker compose run --rm letsencrypt

    # Reload nginx on this container group
    docker exec my_app_nginx nginx -s reload

    # As well as the top_nginx container group
    cd ../top_nginx
    docker exec nginx nginx -s reload
    ```
1. Make a scheduled task to run that script every day. Here's a sample XML file:
    <dl>
        <dt>Command</dt>
        <dd>powershell.exe</dd>
        <dt>Arguments</dt>
        <dd>-ExecutionPolicy Bypass -File backup.ps1</dd>
        <dt>Working Directory</dt>
        <dd>C:\Sites\my_app\</dd>
    </dl>