#
# Cookbook Name:: attribute-validator
# Recipe:: install
#
# Copyright (C) 2013 Clinton Wolfe
# 

chef_gem "chef-attribute-validator" do
  action :nothing
end

resources('chef_gem[chef-attribute-validator]').run_action(:install)
