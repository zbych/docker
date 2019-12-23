ENV PHP_VERSION "5.6"

RUN apt-get update \
    && apt-get -y --no-install-recommends install php5.6 php5.6-fpm php5.6-dev php5.6-curl php5.6-gd php5.6-intl \
        php5.6-json php5.6-phpdbg php5.6-redis php5.6-mysql php5.6-cli php5.6-mcrypt php5.6-apcu php-apc \
        php5.6-readline php5.6-apcu php5.6-pclzip php5.6-xsl php5.6-xdebug php5.6-bcmath php-pear \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Dockerized files needs to be moved to TMP dir.
RUN mkdir /var/docker/ \
    && mkdir /var/docker/php \
    && mkdir /var/docker/php/cli \
    && mkdir /var/docker/php/fpm

# Copy environment files;
COPY .docker/php/xdebug.ini /var/docker/php/
COPY .docker/php/cli/* /var/docker/php/cli/
COPY .docker/php/fpm/* /var/docker/php/fpm/

# Redirect logs:
RUN ln -sf /dev/stderr /var/log/php5-fpm.log
