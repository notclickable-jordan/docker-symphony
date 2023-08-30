# Install

Seed database with these commands:

``` bash
docker-compose run --rm rails bundle exec rails db:create
docker-compose run --rm rails bundle exec rails db:migrate
docker-compose run --rm rails bundle exec rails db:seed_fu
```