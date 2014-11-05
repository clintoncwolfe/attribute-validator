#
# Cookbook Name:: attribute-validator
# Recipe:: install
#
# Copyright (C) 2013 Clinton Wolfe
# 

chef_gem "chef-attribute-validator" do
  action :nothing

  # attribute-validator's only dep is chef ~> 11.6
  # Having the omnibus chef try to upgrade itself as a gem 
  # is pretty much always a disaster; many native packages, may 
  # not have a compiler, etc.
  options "--ignore-dependencies"
end

resources('chef_gem[chef-attribute-validator]').run_action(:install)

require 'chef-attribute-validator'
