FROM debian:stretch
ARG SHARED_UID

MAINTAINER Zbigniew Łabacz <zbigniew.labacz@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get clean && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates apt-transport-https wget gnupg gnupg2 lsb-release \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
    && apt-get update \
    && apt-get -y --no-install-recommends install curl xz-utils cron nginx nginx-common nginx-extras inetutils-ping \
      supervisor dnsutils make vim git ssh mysql-client redis-tools php7.1 php7.1-fpm php7.1-dev php7.1-curl php7.1-gd \
      php7.1-intl php7.1-json php7.1-soap php7.1-phpdbg php7.1-redis php7.1-mysql php7.1-cli php7.1-mcrypt php7.1-opcache \
      php7.1-readline php7.1-memcached php7.1-zip php7.1-xsl php7.1-mbstring php7.1-bcmath php7.1-soap bzip2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && update-ca-certificates


# Create mandatory paths:
RUN mkdir /var/docker/ \
    && mkdir /var/docker/php7 \
    && mkdir /var/docker/php7/fpm \
    && mkdir /var/docker/php7/cli

# Copy templates to Image:
COPY .docker/php7/xdebug.ini /var/docker/php7/
COPY .docker/php7/cli/php.ini /var/docker/php7/cli/
COPY .docker/php7/fpm/php.ini /var/docker/php7/fpm/
COPY .docker/php7/fpm/www.conf /var/docker/php7/fpm/

# Set PHP-FPM running as non-daemon
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.1/fpm/php-fpm.conf

# XDEBUG
ADD https://xdebug.org/files/xdebug-2.6.0.tgz /tmp/xdebug-2.6.0.tgz
RUN tar -C /var/local/ -xzf /tmp/xdebug-2.6.0.tgz
WORKDIR /var/local/xdebug-2.6.0
RUN phpize \
    && chmod u+x configure \
    && ./configure \
    && make \
    && cp /var/local/xdebug-2.6.0/modules/xdebug.so /usr/lib/php/20151012 \
    && touch /etc/php/7.1/mods-available/xdebug.ini \
    && ln -s /etc/php/7.1/mods-available/xdebug.ini /etc/php/7.1/cli/conf.d/20-xdebug.ini \
    && ln -s /etc/php/7.1/mods-available/xdebug.ini /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && rm /tmp/xdebug-2.6.0.tgz
