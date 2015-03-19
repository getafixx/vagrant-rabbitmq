vagrant-rabbitmq
================

Simple vagrant script for creating a development environment for rabbitmq queues as my windows machine will not work with rabbitmq.

Based on https://github.com/mdevilliers/vagrant-rabbitmq-development-environment

Checks out the source code to /vagrant.

Uses the ubuntu/trusty64 box

it sets up rabbitmq, mercurial, zip, xsltproc, esl-erlang, git, apache 

it creates a new user for rabbitmq called test password test (this should be changed)

it also sets up the vagrant home directory with my user scripts from https://github.com/getafixx/Admin-Scripts.sh

To use
------
vagrant up (takes a while)

vagrant halt

