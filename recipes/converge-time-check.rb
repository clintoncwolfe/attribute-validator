#
# Cookbook Name:: attribute-validator
# Recipe:: converge-time-check
#
# Copyright (C) 2013 Clinton Wolfe
# 

include_recipe 'attribute-validator::install'

ruby_block 'convergence time attribute validation' do
  block do
    violas = Chef::Attribute::Validator.new(node).validate_all
    unless violas.empty?
      message  = "The node attributes for this chef run failed validation!\n"
      message += "A total of #{violas.size} violation(s) were encountered.\n"
      message += violas.map { |v| v.rule_name + ' at ' + v.path + ': ' + v.message }.join("\n")
      fail message
    end
  end
end
