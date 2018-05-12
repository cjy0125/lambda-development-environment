# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  os = "bento/ubuntu-16.04"
  net_ip = "192.168.50"
  role = "lambda-dev"

  config.vm.define role, primary: true do |master_config|
    master_config.vm.host_name = "#{role}.devops"
    master_config.vm.network "private_network", ip: "#{net_ip}.100"
    master_config.vm.box = "#{os}"
    master_config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 1
      vb.name = "#{role}.devops-chef"
    end
  end
  #Create Chef-solo related jobs
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "./chef/cookbooks"
    chef.roles_path = "./chef/roles"
    chef.add_role(role)
  end
end
