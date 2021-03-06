#!/bin/sh

echo ">>>>>>> | Updating packages | <<<<<<<"
#do-release-upgrade
sudo apt update -y && sudo apt upgrade -y && sudo apt full-upgrade -y

echo " " && echo ">>>>>>> | Installing Git | <<<<<<<"
sudo add-apt-repository ppa:git-core/ppa
sudo apt install git -y

echo " " && echo ">>>>>>> | Installing Node | <<<<<<<"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm i -g npm
sudo npm install -g nodemon

echo " " && echo ">>>>>>> | Installing Yarn | <<<<<<<"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt install -y yarn

echo " " && echo ">>>>>>> | Installing Mongo | <<<<<<<"
sudo apt install mongodb -y && sudo apt remove mongodb -y && sudo apt autoremove -y
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
sudo apt update && sudo apt install mongodb-org -y

echo " " && echo ">>>>>>> | Instalando PHP 7 | <<<<<<<"
apt install php7.0 libapache2-mod-php7.0 php7.0-opcache php-apcu php7.0-fpm php7.0-cli php7.0-common php7.0-gd php7.0-intl php7.0-xml php7.0-mysql hp7.0-mcrypt php7.0-zip php7.0-curl php-pear php-imagick php7.0-imap php-memcache php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc hp7.0-xsl php7.0-mbstring php-gettext -y

echo " " && echo ">>>>>>> | Instalando Apache | <<<<<<<"
apt install apache2 -y
echo "<?php phpinfo(); ?>" >> /var/www/html/info.php
chown www-data:www-data /var/www/html/info.php

echo " " && echo ">>>>>>> | Installing MySQL | <<<<<<<"
curl -OL https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb
sudo dpkg -i mysql-apt-config*
sudo apt update -y
rm mysql-apt-config*

sudo dpkg-reconfigure mysql-apt-config
sudo apt update -y
sudo apt install mysql-server -y
#mysql_secure_installation
#systemctl status mysql
#echo -e "[client]\nprotocol=tcp" >> /etc/mysql/mysql.conf.d/mysqld.cnf
#mysqladmin -u root -p version

echo " " && echo ">>>>>>> | Installing Docker | <<<<<<<"
sudo apt remove -y docker docker-engine docker.io
# Environment variables you need to set so you don't have to edit the script below.
export DOCKER_CHANNEL=edge
export DOCKER_COMPOSE_VERSION=1.21.2
# Update the apt package index.
sudo apt-get update
# Install packages to allow apt to use a repository over HTTPS.
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
# Add Docker's official GPG key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Verify the fingerprint.
sudo apt-key fingerprint 0EBFCD88
# Pick the release channel.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   ${DOCKER_CHANNEL}"
# Update the apt package index.
sudo apt-get update
# Install the latest version of Docker CE.
sudo apt-get install -y docker-ce
# Allow your user to access the Docker CLI without needing root.
sudo usermod -aG docker $USER
# Install Docker Compose.
sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose

#echo " " && echo ">>>>>>> | Instalando Redis | <<<<<<<"
### Not tested yet ###
#sudo add-apt-repository ppa:chris-lea/redis-server
#sudo apt-get update
#sudo apt-get install redis-server
#redis-cli

echo " " && echo ">>>>>>> | Limpando pacotes não necessários | <<<<<<<"
sudo apt-get autoremove -y

echo " " && echo ">>>>>>> | End of process. Succesfull installation | <<<<<<<"
