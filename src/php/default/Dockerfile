#_ENVIRONMENT_

# Create mandatory paths:
RUN mkdir /var/docker/  \
    && mkdir /var/docker/etc  \
    && mkdir /var/docker/nginx

# Copy templates to Image:
COPY .docker/run.sh /var/docker/
COPY .docker/nginx/default.conf /var/docker/nginx/
COPY .docker/nginx/nginx.conf /var/docker/nginx/
COPY .docker/supervisor/supervisord.conf /etc/supervisor/conf.d/
COPY .docker/tools/* /usr/local/bin/

#_APPLICATION_

# Curl
ADD https://curl.haxx.se/ca/cacert.pem /var/www

# Dockerize
ADD https://github.com/jwilder/dockerize/releases/download/v0.5.0/dockerize-linux-amd64-v0.5.0.tar.gz /tmp/dockerize.tgz
RUN tar -C /usr/local/bin -xzf /tmp/dockerize.tgz \
    && rm /tmp/dockerize.tgz

# Composer
ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

# NODE, GRUNT
ADD https://nodejs.org/dist/v8.11.4/node-v8.11.4-linux-x64.tar.xz /tmp/node-v8.11.4-linux-x64.tar.xz
RUN unxz /tmp/node-v8.11.4-linux-x64.tar.xz \
    && tar -C /usr/local/ -xf /tmp/node-v8.11.4-linux-x64.tar \
    && rm /tmp/node-v8.11.4-linux-x64.tar \
    && export PATH=$PATH:/usr/local/node-v8.11.4-linux-x64/bin \
    && npm install -g gulp

# Sendmail (MailHog -> MailCatcher)
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail \
    && cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

RUN mkdir -p /run/php \
    && chmod 777 /var/docker/run.sh \
    && usermod -u $SHARED_UID www-data \
    && chsh -s /bin/bash www-data \
    && mkdir -p /var/www/current \
    && chown www-data:www-data -R /var/www

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 80
WORKDIR /var/www/current
CMD ["/var/docker/run.sh"]
