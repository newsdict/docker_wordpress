FROM php:7.3.8-fpm

# Init php
RUN apt update
RUN apt install -y --no-install-recommends libzip-dev nginx default-mysql-client
RUN docker-php-ext-install zip mysqli mbstring opcache

WORKDIR /usr/local/src

# For dotenv-php
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN php composer.phar require vlucas/phpdotenv

# Init wordpress
RUN curl https://wordpress.org/latest.tar.gz  |tar zx
ADD docroot/wordpress/wp-config.php /usr/local/src/wordpress/wp-config.php
ADD docroot/index.php /var/www/index.php
ADD .env /.env

# Init nginx
ADD nginx/default /etc/nginx/sites-available/default
ADD docker_cmd.sh /docker_cmd.sh
RUN chmod +x /docker_cmd.sh
RUN /bin/chown www-data.www-data -R /usr/local/src/wordpress

# Rename dirname for security
RUN . /.env && if [ ! -L /var/www/$WP_SUFFIX ]; then ln -s /usr/local/src/wordpress /var/www/$WP_SUFFIX; fi 

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD /docker_cmd.sh
EXPOSE 80