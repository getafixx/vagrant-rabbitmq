#!/bin/bash
export DEBIAN_FRONTEND=noninteractive 

# erlang for RabbitMQ
wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb

cat >> /etc/apt/sources.list <<EOT
deb http://www.rabbitmq.com/debian/ testing main
EOT

#set mysql box root password.
debconf-set-selections <<< 'mysql-server mysql-server/root_password password test123'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password test123'

#wget http://www.dotdeb.org/dotdeb.gpg -O- | apt-key add -

wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc 
apt-key add rabbitmq-signing-key-public.asc

apt-get update

apt-get install -y make git mercurial zip xsltproc esl-erlang 

apt-get install -y screen htop vim curl wget
apt-get install -y rabbitmq-server


# RabbitMQ Plugins
service rabbitmq-server stop
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_jsonrpc
service rabbitmq-server start

rabbitmq-plugins list

#RabbitMQ - create test user - just for demo... 
rabbitmqctl add_user test test
rabbitmqctl set_user_tags test administrator
rabbitmqctl set_permissions -p / test ".*" ".*" ".*"

#install PHP and Apache and Mysql
add-apt-repository ppa:ondrej/php5-5.6
apt-get update
apt-get install -y python-software-properties
apt-get update
apt-get install -y php5

apt-get install -y mysql-server mysql-client php5-mysql apache2 libapache2-mod-php5
apt-get install -y curl php5-gd php-apc php5-curl php5-mcrypt php5-xdebug php5-common php5-cli 
apt-get install -y php5-tidy php5-imagick php5-redis apache2-utils php5-gearman php5-geoip
apt-get install -y libapache2-mod-auth-mysql

service apache2 stop

a2enmod auth_mysql

php5enmod mcrypt

# Enable mod_rewrite
a2enmod rewrite

# Add www-data to vagrant group
usermod -a -G vagrant www-data

# Settting up Apache for PHP
rm -rf /etc/apache2/mods-enabled/dir.conf
cat >> /etc/apache2/mods-enabled/dir.conf <<EOT
<IfModule mod_dir.c>
          DirectoryIndex index.php index.html index.cgi index.pl index.php index.xhtml index.htm\
</IfModule>
EOT

# install phpmyadmin
apt-get install -y phpmyadmin
#set up 
cat >> /etc/apache2/apache2.conf <<EOT

# phpMyAdmin Configuration
Include /etc/phpmyadmin/apache.conf

EOT

# setting up shared HTML dir.
rm -rf /var/www
ln -fs /vagrant/www /var/www

service apache2 start

cat >/etc/mercurial/hgrc <<-EOF
		[trusted]
		users = vagrant
	EOF

# set up vagrant home directory base files
mkdir ./adminScripts
git clone https://github.com/getafixx/Admin-Scripts.sh ./adminScripts
cp -v ./adminScripts/.* ~/
cp -v ./adminScripts/.* ./
chown vagrant.vagrant .*

# create dataabase and inport data
mysql -uroot -ptest123  -e "create database overlay";
mysql -uroot -ptest123 --h localhost overlay < overlay.sql

#install PHP Storm depebdancies
apt-get purge openjdk*
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java7-installer

#Install PhpStorm - this download has already been done..
#wget http://download-cf.jetbrains.com/webide/PhpStorm-8.0.1.tar.gz

tar -xvf /vagrant/PhpStorm-8.0.1.tar.gz
