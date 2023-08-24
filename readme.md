# About

Docker compose files for personal services. Some services are exposed to the Internet, others are served to the local network and any devices using Tailscale. Hosting provided by Cloudflare.

## Prerequisites

- [Tailscale](https://tailscale.com/download/)
- [Docker engine](https://docs.docker.com/engine/install/)
- [Docker compose](https://docs.docker.com/compose/install/)
- [Cloudflared](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation)

## Environment variables

Many services mention `env_file` in their `compose.yml`. For security reasons these files are not checked in.

# Services and ports

- nginx (80, 443)
- Mastodon (8010-8013)
- Jellyfin (8030)
- Calibre (8040)
- Miniflux (8050)
- N8N (8060)
- MeTube (8080)
- Homepage (8090)
- Gitea (8100)
- Mealie (8110)
- Visual Studio Code (8120)
- Vaultwarden (8130)
- Roher Twins (8150)
- Portainer (8160)
- Calibre (8170)
- Wallabag (8180)
- Standard Notes (8190-8192)
- Shamir's Secret Sharing Scheme (8200)
- Outline (8210)
- Draw.io (8220)
- ROMM (8230)
- FileGator (8240)
- Gramps (8250)

# Cloudflare

All publicly facing websites are served via Cloudflare Tunnels. To edit them, use the [Cloudflare Dashboard](https://dash.cloudflare.com) to enter Zero Trust. Select Access > Tunnels and manage `starbase-80`. Select the "Public Hostname" tab to add a new subdomain.

Be sure to set the **HTTP Host Header** to `subdomain.starbase80.dev`. When adding SSL sites, set the **Origin Server Name** to the same value and check **No TLS Verify**.

Run `systemctl restart cloudflared` after updating any Cloudflare config. Not necessary when adding public hostnames.

# SSL certificates

Publicly facing websites should get SSL certificates from Let's Encrypt on top of Cloudflare's SSL.

1. Create a new public hostname in Cloudflare Zero Trust
1. Set the service to be http://localhost:80
1. In `/nginx/sites`, add a new `.conf` for the site
    - Fill out the `server listen 80` block and comment out the `server listen 443` block
    - Ensure the `server listen 80 location /` block ends with `proxy_pass http://service_name_backend;`
1. Modify `/nginx/docker-compose.yml` to expose the `letsencrypt_one` service and comment out the `letsencrypt` service
1. Restart nginx: `docker exec switchboard nginx -s reload`
1. In `/nginx`, run `docker compose up -d` to start the `letsencrypt_one` service
1. Check in Portainer that the `letsencrypt_one` service exited after saving the certificate
1. Modify `/nginx/docker-compose.yml` to expose the `letsencrypt` service and comment out the `letsencrypt_one` service
1. Modify the `/nginx/sites/service_name.conf` file
    - Comment out the `server listen 80` block
    - Uncomment the `server listen 443` block
1. Restart nginx: `docker exec switchboard nginx -s reload`
1. Go back to Cloudflare Zero Trust and change the service to be https://localhost:443
1. Set the **Origin Server Name** to the same value as **HTTP Host Header** and check **No TLS Verify**

# File permissions

When adding .sh files, run `chmod +x <filename>` to make them executable. Or run this from the root:

``` bash
sudo find . -name "*.sh" -exec chmod +x {} \;
```

# Cron jobs

``` bash
# Run this to edit the crontab
crontab -e -u jordan

# Add these lines to the crontab
0 2 * * * /bin/bash /home/jordan/docker-symphony/nginx/renew.sh
0 3 * * * /bin/bash /home/jordan/docker-symphony/backup-all.sh
```

# Docker entering a container

``` bash
docker exec -it container_name bash
```