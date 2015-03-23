# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"
 
  # Configure network interface
  config.vm.network "public_network", ip: "192.168.56.200"

  # port forwards
  config.vm.network :forwarded_port, guest: 80, host: 8080
  
  #rabbit mq 
  config.vm.network :forwarded_port, guest: 5672, host: 5672
  
  #rabbit mq Management
  config.vm.network :forwarded_port, guest: 15672, host: 15672
  
  #set up Root http folder
  config.vm.synced_folder "./www/", "/vagrant/www"


  #provision machine
  config.vm.provision 'shell', path: 'provision.sh'
  
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
      vb.memory = "1024"
   end
end
