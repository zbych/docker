#_ENVIRONMENT_

ENV DOCKERIZE_VERSION "v0.6.1"

# Blackfire
RUN test -n "$BLACKFIRE_ENABLED" \
    && version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && mkdir -p /tmp/blackfire \
    && tar -xzf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire-*.so $(php-config --extension-dir)/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > /etc/php/$PHP_VERSION/mods-available/blackfire.ini \
    && rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz

# Create mandatory paths:
RUN mkdir -p /var/docker/ \
    && mkdir -p /var/docker/nginx/sites-available \
    && mkdir -p /var/www/bin \
    && mkdir /var/docker/sql

# Copy templates to Image:
COPY .docker/run.sh /var/docker/
COPY .docker/nginx/nginx.conf /var/docker/nginx/
COPY .docker/nginx/sites-available/* /var/docker/nginx/sites-available/
COPY .docker/supervisor/supervisord.conf /etc/supervisor/conf.d/
COPY .docker/tools/* /usr/local/bin/

#_APPLICATION_

# Dockerize
ADD https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    /tmp/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
    
RUN tar -C /usr/local/bin -xzf /tmp/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm /tmp/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Composer
ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

# NODE, GRUNT
ADD https://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.xz /tmp/node-$NODE_VERSION-linux-x64.tar.xz
RUN unxz /tmp/node-$NODE_VERSION-linux-x64.tar.xz \
    && tar -C /var/www/bin -xf /tmp/node-$NODE_VERSION-linux-x64.tar \
    && rm /tmp/node-$NODE_VERSION-linux-x64.tar \
    && export PATH=$PATH:/var/www/bin/node-$NODE_VERSION-linux-x64/bin

# Sendmail (MailHog -> MailCatcher)
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail \
    && cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

RUN mkdir -p /run/php \
    && chmod 777 /var/docker/run.sh \
    && usermod -u $SHARED_UID www-data \
    && chsh -s /bin/bash www-data \
    && mkdir -p %ROOT_PATH% \
    && find /usr/local/bin/ -type f -iname "*.sql" -exec mv {} /var/docker/sql \;

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443
WORKDIR %ROOT_PATH%
CMD ["/var/docker/run.sh"]
