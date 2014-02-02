# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.hostname = 'attribute-validator-ci'
  config.vm.box = 'Berkshelf-CentOS-6.3-x86_64-minimal'
  config.vm.box_url = 'https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box'

  config.berkshelf.enable = true

  config.vm.provision :chef_solo do |chef|
    chef.log_level = (ENV['CHEF_LOG_LEVEL'] ? ENV['CHEF_LOG_LEVEL'].to_sym : :info)
    chef.run_list = [
        'recipe[attribute-validator::install]'
    ]

    if ENV['CAV_VAGRANTFILE_FIXTURE']
      fixture_file = File.join(Dir.pwd, 'test', 'fixtures', ENV['CAV_VAGRANTFILE_FIXTURE'])
      instance_eval(File.read(fixture_file))
    end

  end
end
