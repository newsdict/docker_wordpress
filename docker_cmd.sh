#!/bin/sh
# Init wordpress and container
set -ex
. /.env
mysql -u$DB_USER -p$DB_PASSWORD -h$DB_HOST -e "create database IF NOT EXISTS $DB_NAME charset utf8"
chown www-data.www-data -R /usr/local/src/wordpress
nginx -c /etc/nginx/nginx.conf
php-fpm