#
# Cookbook Name:: attribute-validator
# Recipe:: compile-time-check
#
# Copyright (C) 2013 Clinton Wolfe
# 

include_recipe 'attribute-validator::install'

Chef::Log.info('Running compile-time node attribute validations')
violas = Chef::Attribute::Validator.new(node).validate_all
unless violas.empty?
  message  = "The node attributes for this chef run failed validation!\n"
  message += "A total of #{violas.size} violation(s) were encountered.\n"
  message += violas.map { |v| v.rule_name + ' at ' + v.path + ': ' + v.message }.join("\n")
  fail message
end
