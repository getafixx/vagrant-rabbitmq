#!/bin/bash

wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb


cat >> /etc/apt/sources.list <<EOT
deb http://www.rabbitmq.com/debian/ testing main
EOT

wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc

apt-get update
 
apt-get -y install make mercurial zip xsltproc esl-erlang git

apt-get install -q -y screen htop vim curl wget
apt-get install -q -y rabbitmq-server

# RabbitMQ Plugins
service rabbitmq-server stop
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_jsonrpc
service rabbitmq-server start

rabbitmq-plugins list

export DEBIAN_FRONTEND=noninteractive 

cat >/etc/mercurial/hgrc <<-EOF
		[trusted]
		users = vagrant
	EOF

#set up vagrant home directory base
mkdir ./adminScripts
git clone https://github.com/getafixx/Admin-Scripts.sh ./adminScripts
mv -v ./adminScripts/.* ./
chown vagrant.vagrant .*

#override the stupid guest user 
rabbitmqctl add_user test test
rabbitmqctl set_user_tags test administrator
rabbitmqctl set_permissions -p / test ".*" ".*" ".*"


