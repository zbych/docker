
# CONFIGURE ENVIRONMENT

dockerize \
    -template=/var/docker/php7/cli/php.ini:/etc/php/7.2/cli/php.ini \
    -template=/var/docker/php7/fpm/php.ini:/etc/php/7.2/fpm/php.ini \
    -template=/var/docker/php7/fpm/www.conf:/etc/php/7.2/fpm/pool.d/www.conf \
    -template=/var/docker/php7/xdebug.ini:/etc/php/7.2/mods-available/xdebug.ini \
    /bin/true

# Clean logs
echo "" > /var/log/php7.2-fpm.log
