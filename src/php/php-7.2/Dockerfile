FROM debian:jessie
ARG SHARED_UID
ARG NODE_VERSION

MAINTAINER Zbigniew Łabacz <zbigniew.labacz@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl wget apt-transport-https lsb-release ca-certificates \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

RUN apt-get update \
    && apt-get -y --no-install-recommends install xz-utils cron nginx inetutils-ping supervisor dnsutils make vim git \
      ssh g++ mysql-client redis-tools php7.2 php7.2-common php7.2-fpm php7.2-dev php7.2-curl php7.2-gd php7.2-intl \
      php7.2-json php7.2-soap php7.2-phpdbg php7.2-mysql php7.2-cli php7.2-opcache php7.2-zip php7.2-xsl openssl \
      php7.2-mbstring php7.2-bcmath bzip2 unzip patch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && update-ca-certificates

# Create mandatory paths:
RUN mkdir /var/docker/ \
    && mkdir /var/docker/php \
    && mkdir /var/docker/php/fpm \
    && mkdir /var/docker/php/cli

# Copy templates to Image:
COPY .docker/php/xdebug.ini /var/docker/php/
COPY .docker/php/cli/* /var/docker/php/cli/
COPY .docker/php/fpm/* /var/docker/php/fpm/

# Set PHP-FPM running as non-daemon
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.2/fpm/php-fpm.conf

# Increase Opcache Limit:
RUN echo "opcache.memory_consumption=256" >> /etc/php/7.2/mods-available/opcache.ini

# XDEBUG
ADD https://xdebug.org/files/xdebug-2.6.0.tgz /tmp/xdebug-2.6.0.tgz
RUN tar -C /var/local/ -xzf /tmp/xdebug-2.6.0.tgz
WORKDIR /var/local/xdebug-2.6.0
RUN phpize \
    && chmod u+x configure \
    && ./configure \
    && make \
    && cp /var/local/xdebug-2.6.0/modules/xdebug.so /usr/lib/php/20170718 \
    && touch /etc/php/7.2/mods-available/xdebug.ini \
    && ln -s /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/cli/conf.d/20-xdebug.ini \
    && ln -s /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/fpm/conf.d/20-xdebug.ini \
    && rm /tmp/xdebug-2.6.0.tgz
