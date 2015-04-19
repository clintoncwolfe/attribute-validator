#
# Cookbook Name:: attribute-validator
# Recipe:: install
#
# Copyright (C) 2013 Clinton Wolfe
# 

chef_gem "chef-attribute-validator" do
  # force installation at compile time in chef >= 12
  compile_time true if defined? compile_time

  # attribute-validator's only dep is chef ~> 11.6
  # Having the omnibus chef try to upgrade itself as a gem 
  # is pretty much always a disaster; many native packages, may 
  # not have a compiler, etc.
  options "--ignore-dependencies"
end
require 'chef-attribute-validator'
