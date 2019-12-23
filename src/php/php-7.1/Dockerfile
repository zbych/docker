ENV PHP_VERSION "7.1"

RUN apt-get update \
    && apt-get -y --no-install-recommends install php7.1 php7.1-fpm php7.1-dev php7.1-curl php7.1-gd php7.1-intl \
       php7.1-json php7.1-soap php7.1-phpdbg php7.1-redis php7.1-mysql php7.1-cli php7.1-mcrypt php7.1-opcache \
       php7.1-readline php7.1-memcached php7.1-zip php7.1-xsl php7.1-mbstring php7.1-bcmath php7.1-soap php-pear \
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
RUN echo "opcache.memory_consumption=256" >> /etc/php/7.1/mods-available/opcache.ini

# XDEBUG
RUN pecl install xdebug

# Redirect logs:
RUN ln -sf /dev/stderr /var/log/php7.1-fpm.log