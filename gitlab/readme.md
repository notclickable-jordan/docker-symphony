# Initial setup

After creating the container, the root login won't work. Go into the container manually to set the password.

1. `docker exec -it <container_id> /bin/bash`
2. Run `gitlab-rake "gitlab:password:reset"`
3. Enter a user name, in this case 'root' (no quotes) and password

# Runner

To launch a short-lived gitlab-runner container to register the container you created during installation:

1. `docker run --rm -it -v gitlab_runner:/etc/gitlab-runner gitlab/gitlab-runner:latest register`
2. GitLab instance URL: `http://192.168.1.15:8280`
3. Entered registration token and name
4. Executor: `docker`
5. Default image: `node:16`