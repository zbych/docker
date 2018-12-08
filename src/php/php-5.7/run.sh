
# CONFIGURE ENVIRONMENT

dockerize \
    -template=/var/docker/php/cli/php.ini:/etc/php5/cli/php.ini \
    -template=/var/docker/php/fpm/php.ini:/etc/php5/fpm/php.ini \
    -template=/var/docker/php/fpm/www.conf:/etc/php5/fpm/pool.d/www.conf \
    -template=/var/docker/php/xdebug.ini:/etc/php5/mods-available/xdebug.ini

# Clean logs
echo "" > /var/log/nginx/php5-fpm.log
