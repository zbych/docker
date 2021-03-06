ENV PHP_VERSION "7.2"

RUN apt-get update \
    && apt-get -y --no-install-recommends install php7.2 php7.2-common php7.2-fpm php7.2-dev php7.2-curl php7.2-gd \
        php7.2-intl php7.2-json php7.2-soap php7.2-phpdbg php7.2-mysql php7.2-cli php7.2-opcache php7.2-zip php7.2-xsl \
        php7.2-mbstring php7.2-bcmath php-pear \
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
RUN echo "opcache.memory_consumption=256" >> /etc/php/7.2/mods-available/opcache.ini

# XDEBUG
RUN pecl install xdebug

# Redirect logs:
RUN ln -sf /dev/stderr /var/log/php7.2-fpm.log
