# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.hostname = 'attribute-validator-ci'
  config.vm.box = 'Berkshelf-CentOS-6.3-x86_64-minimal'
  config.vm.box_url = 'https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box'

  config.vm.provision :chef_solo do |chef|
    chef.json = {
    }

    chef.run_list = [
        'recipe[attribute-validator::install]'
    ]
  end
end
