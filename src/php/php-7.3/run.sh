
# CONFIGURE ENVIRONMENT
export PHP_LIB_LOCATION=$(php-config --extension-dir)
dockerize \
    -template=/var/docker/php/cli/php.ini:/etc/php/7.3/cli/php.ini \
    -template=/var/docker/php/fpm/php.ini:/etc/php/7.3/fpm/php.ini \
    -template=/var/docker/php/fpm/www.conf:/etc/php/7.3/fpm/pool.d/www.conf \
    -template=/var/docker/php/xdebug.ini:/etc/php/7.3/mods-available/xdebug.ini

phpenmod xdebug

