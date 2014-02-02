#
# Cookbook Name:: attribute-validator
# Recipe:: install
#
# Copyright (C) 2013 Clinton Wolfe
# 

chef_gem "chef-attribute-validator" do
  action :nothing

  # Without conservative, we may try to upgrade chef(!)   
  # On machines without compilers, this will fail (puma, among
  # others, is a local compile)
  options " --conservative "
end

resources('chef_gem[chef-attribute-validator]').run_action(:install)

# Because we pass options as a string above, the gem install 
# happened in a subprocess.  So, the current ruby process's 
# gem search path is stale.
Gem.refresh()

# OK, should be able to find this now.
require 'chef-attribute-validator'
