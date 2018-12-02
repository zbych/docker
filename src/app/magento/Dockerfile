# <APPLICATION>

# Magerun
ADD https://files.magerun.net/n98-magerun.phar /usr/local/bin/magerun
RUN chmod +rx /usr/local/bin/magerun

# Dockerized files needs to be moved to TMP dir.
RUN mkdir /var/docker/etc

# Copy files to Image:
COPY .docker/etc/local.xml /var/docker/etc/

# </APPLICATION>
