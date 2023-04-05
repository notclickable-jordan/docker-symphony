# Map network share to Docker volume

Run this independently in the command line, then mount the volume in the docker-compose.yml file as `external: true`

``` powershell
docker volume create --driver local --opt type=cifs --opt device=//ip.address/folder --opt o=user=username,password=password volume_name
```

It worked for me once, then I couldn't get it to work again.