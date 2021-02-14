#!/bin/sh
# Init wordpress and container
set -ex
. /.env
chown www-data.www-data -R /usr/local/src/wordpress
nginx -c /etc/nginx/nginx.conf
php-fpm