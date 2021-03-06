ENV PHP_VERSION "7.3"

RUN apt-get update \
    && apt-get -y --no-install-recommends install php7.3 php7.3-common php7.3-fpm php7.3-dev php7.3-curl php7.3-gd \
        php7.3-intl php7.3-json php7.3-soap php7.3-phpdbg php7.3-mysql php7.3-cli php7.3-opcache php7.3-zip php7.3-xsl \
        php7.3-mbstring php7.3-bcmath php-pear \
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
RUN echo "opcache.memory_consumption=256" >> /etc/php/7.3/mods-available/opcache.ini

# XDEBUG
RUN pecl install xdebug

# Redirect logs:
RUN ln -sf /dev/stderr /var/log/php7.3-fpm.log
