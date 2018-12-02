# Docker based Magento Fast Environment #

### Available Variations:
 - Magento 1.x with PHP5, PHP7.0, PHP7.1, PHP.7.2
 - Magento 2.x with PHP5, PHP7.0, PHP7.1, PHP.7.2
 - WordPress with PHP5, PHP7.0, PHP7.1, PHP.7.2
 
### Utilizes
 - docker-compose v3
 - MySQL (Percona)
 - Redis
 - Mailcatcher with Mailhog

### Web Images supports:
 - Nginx
 - PHP-FPM
 - Node (npm)
 - Composer
 - Xdebug (even in PHP7)

### INSTALLATION
 - Clone repo to ~/dev/
 - Move docker-project-init to ~/bin/

### How to use?
 - Clone your working copy of Magento or Magento2
 - `docker-project-init platform application name` 
 - Adjust .env file if needed
 - Run `sudo docker-compose up`
 - Enjoy
