ENV PHP_VERSION "7.4"

RUN apt-get update \
    && apt-get -y --no-install-recommends install php7.4 php7.4-common php7.4-fpm php7.4-dev php7.4-curl php7.4-gd \
        php7.4-intl php7.4-json php7.4-soap php7.4-phpdbg php7.4-mysql php7.4-cli php7.4-opcache php7.4-zip php7.4-xsl \
        php7.4-mbstring php7.4-bcmath php-pear \
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
RUN echo "opcache.memory_consumption=256" >> /etc/php/7.4/mods-available/opcache.ini

# XDEBUG
RUN pecl install xdebug

# Redirect logs:
RUN ln -sf /dev/stderr /var/log/php7.4-fpm.log