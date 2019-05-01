# Docker based Magento Fast Environment #
Tailored for Debian/Ubuntu distributions.

### Requirements:
* Linux based systems (Debian)
* Docker: 18.x
* docker-compose: 1.23
* Binaries: awk, sed, ifconfig, git
* Released ports: 3306 (mysql), 80 (apache,nginx), 6379 (redis), 1080, 1025

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

### INSTALL
`curl -sSL https://raw.githubusercontent.com/zbych/docker/master/install.sh | bash`

### How to use?
 - Clone your working copy of Magento or Magento2
 - `docker-project-init <platform> <application> <name>` 
 - Adjust .env file if needed
 - Run `sudo docker-compose up`
 - Enjoy
 
### Platforms:
 - php-7.0
 - php-7.1
 - php-7.2
 - php-5.7
 
### Applications
 - magento
 - magento2
 - wp
