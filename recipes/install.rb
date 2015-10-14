#
# Cookbook Name:: attribute-validator
# Recipe:: install
#
# Copyright (C) 2013 Clinton Wolfe
# 

# Undocumented: for development, you may set node['attribute-validator']['local-install'] to a version string
# and we will install the matching gem from the local files/ directory of the cookbook
if node['attribute-validator']['local-install'] then
  r = cookbook_file '/tmp/chef-attribute-validator-' + node['attribute-validator']['local-install'] + '.gem'
  r.run_action(:create)
  chef_gem "chef-attribute-validator" do
    compile_time true
    source '/tmp/chef-attribute-validator-' + node['attribute-validator']['local-install'] + '.gem'
    options "--ignore-dependencies"
  end
else
  
  chef_gem "chef-attribute-validator" do
    compile_time true
    
    # attribute-validator's only dep is chef ~> 11.6
    # Having the omnibus chef try to upgrade itself as a gem 
    # is pretty much always a disaster; many native packages, may 
    # not have a compiler, etc.
    # This option causes it to not attempt to install deps, while still
    # aborting if a dep conflict arises.

    options "--ignore-dependencies"
  end
end

require 'chef-attribute-validator'
