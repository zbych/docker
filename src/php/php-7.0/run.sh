# Dockerize configuration files
dockerize \
    -template=/var/docker/php7/cli/php.ini:/etc/php/7.0/cli/php.ini \
    -template=/var/docker/php7/fpm/php.ini:/etc/php/7.0/fpm/php.ini \
    -template=/var/docker/php7/fpm/www.conf:/etc/php/7.0/fpm/pool.d/www.conf \
    -template=/var/docker/php7/xdebug.ini:/etc/php/7.0/mods-available/xdebug.ini \
    /bin/true

echo "" > /var/log/php7.0-fpm.log
