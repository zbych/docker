# <APPLICATION>

# Magerun
ADD https://files.magerun.net/n98-magerun2.phar /usr/local/bin/magerun
RUN chmod 755 /usr/local/bin/magerun

# Create mandatory paths:
RUN mkdir /var/docker/etc

# Copy templates to Image:
COPY .docker/etc/env.php /var/docker/etc/

# </APPLICATION>
