# docker_wordpress

## Start up

```
$ cd wordpress
$ cp env.example .env
$ vim .env # Edit environments of docker container
$ docker-compose build
```

## How to change the wordpress directory.

Edit value of `WP_SUFFIX` on .env

## Development
```
$ sudo docker-compose up -d
```
