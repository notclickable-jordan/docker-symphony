# Initial setup

After creating the container, the root login won't work. Go into the container manually to set the password.

1. `docker exec -it <container_id> /bin/bash`
2. Run `gitlab-rake "gitlab:password:reset"`
3. Enter a user name, in this case 'root' (no quotes) and password