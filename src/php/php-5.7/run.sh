# Configure PHP Env:
dockerize \
    -template=/var/docker/php5/cli/php.ini:/etc/php5/cli/php.ini \
    -template=/var/docker/php5/fpm/php.ini:/etc/php5/fpm/php.ini \
    -template=/var/docker/php5/fpm/www.conf:/etc/php5/fpm/pool.d/www.conf \
    -template=/var/docker/php5/xdebug.ini:/etc/php5/mods-available/xdebug.ini \
    /bin/true

# Clean logs
echo "" > /var/log/nginx/php5-fpm.log
