ENV PHP_VERSION "7.0"

RUN apt-get update \
    && apt-get -y --no-install-recommends install php7.0 php7.0-fpm php7.0-dev php7.0-curl php7.0-gd php7.0-intl \
       php7.0-json php7.0-soap php7.0-phpdbg php7.0-redis php7.0-mysql php7.0-cli php7.0-mcrypt php7.0-opcache \
       php7.0-readline php7.0-memcached php7.0-zip php7.0-xsl php7.0-mbstring php7.0-bcmath php-pear \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Create mandatory paths:
RUN mkdir /var/docker/ \
    && mkdir /var/docker/php \
    && mkdir /var/docker/php/fpm \
    && mkdir /var/docker/php/cli

# Copy templates to Image:
COPY .docker/php/xdebug.ini /var/docker/php/
COPY .docker/php/cli/* /var/docker/php/cli/
COPY .docker/php/fpm/* /var/docker/php/fpm/

# Increase Opcache Limit:
RUN echo "opcache.memory_consumption=256" >> /etc/php/7.0/mods-available/opcache.ini

# XDEBUG
RUN pecl install xdebug

# Redirect logs:
RUN ln -sf /dev/stderr /var/log/php7.0-fpm.log
