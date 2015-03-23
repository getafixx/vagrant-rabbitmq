vagrant-rabbitmq
================

Simple vagrant script for creating a development environment for rabbitmq queues as my windows machine will not work with rabbitmq.

Based on [vagrant-rabbitmq-development-environment](https://github.com/mdevilliers/vagrant-rabbitmq-development-environment)

Checks out the source code to /vagrant.

Uses the ubuntu/trusty64 box

It sets up php 5.6, Apache 2.4.12, MySql 5.5.41, rabbitmq, mercurial, zip, xsltproc, esl-erlang, git

It creates a new user for rabbitmq called test password test (this should be changed)

It also sets up the vagrant home directory with my [user scripts](https://github.com/getafixx/Admin-Scripts.sh)

## Install

* Download and install [Vagrant](http://downloads.vagrantup.com/)
* Download and install  [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Clone the project ```git clone --recursive git@github.com:getafixx/vagrant-rabbitmq.git```
* In the project dir run ```vagrant up```

## Installed Services

### RabbitMQ

host: localhost  
port: 5672  

### RabbitMQ Web client

url: http://localhost:15672/  
username: test  
password: test  

## Vagrant basic commands

* start box: ```vagrant up```
* ssh into box: ```vagrant ssh```
* shutdown box: ```vagrant halt```
* suspend box: ```vagrant suspend``
* destroy box: ```vagrant destroy```

## Links: 
-  [Vagrant](http://downloads.vagrantup.com/)
-  [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
