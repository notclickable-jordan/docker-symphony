# About

Docker compose files for personal services. Some services are exposed to the Internet, others are served to the local network and any devices using Tailscale. DNS records are updated using DirectUpdate.

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop/)
- [Tailscale](https://tailscale.com/download/)
- [DirectUpdate](https://www.directupdate.net/)

## Environment variables

Many services mention `env_file` in their `compose.yml`. These are stored in 1Password and must be manually created in each folder.

# Services and ports

## Cloudflare

Run `systemctl restart cloudflared` after updating any Cloudflare config. Not necessary when adding public hostnames.

- NotClickable.social (7010, 7011)

## TCP
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
- Ghost - Roher Twins (8150)
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
- Coder (8260)

# Automation

## Cron jobs

``` bash
crontab -e -u jordan

0 2 * * * /bin/bash /home/jordan/docker-symphony/nginx/renew.sh
0 3 * * * /bin/bash /home/jordan/docker-symphony/backup-all.sh
```

# DirectUpdate

Create a new DNS account:

- **Account Type:** NameCheap.com
- **User name/Login:** your-domain.tld (e.g.: mydomain.com)
- **Password:** the 25+ charater namecheap DDNS key your-domain.com (e.g. 78bb2321f2b777ff8c24c59234mkm3)
- **Domain/Host:** your-subdomain.your-domain.tld (e.g. mysubdomain.mydomain.com)
- Uncheck **Disable/ignore this account**