#!/bin/sh
# Init wordpress and container
set -ex
. /.env
mysql -u$DB_USER -p$DB_PASSWORD -h$DB_HOST -e "create database $DB_NAME IF NOT EXISTS $DB_NAME charset utf8"
nginx -c /etc/nginx/nginx.conf
php-fpm