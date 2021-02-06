
# CONFIGURE APPLICATION

if [[ ! -f /var/docker/.built ]] ; then
    su www-data -c 'wget https://get.symfony.com/cli/installer -O - | bash'
fi;
