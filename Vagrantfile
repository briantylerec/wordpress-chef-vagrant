Vagrant.configure("2") do |config|
  
  # OS configs
  config.vm.box = "base"
  config.vm.box = "bento/ubuntu-22.04"

  # Memory and cpu
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
  curl -L https://chef.io/chef/install.sh | sudo bash
  SHELL

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.nodes_path = "nodes"
    chef.add_recipe "apache"
    chef.add_recipe "mysql"
    chef.add_recipe "php"
    chef.add_recipe "wordpress"
    chef.arguments = "--chef-license accept"
    chef.install = false
  end
end
