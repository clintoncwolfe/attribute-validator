# -*-ruby-*-

require 'rake'
# require 'rspec/core/rake_task'

desc 'Runs all development tests'
task :test

task :test => [:syntax]
desc 'Checks ruby files for syntax errors'
task :syntax do |t|
  puts '------------Syntax-----------'
  Dir.glob('**/*.rb').each do |f|
    system("/bin/echo -n '#{f}:  '; ruby -c #{f}")
  end
end

task :test => [:rubocop]
desc 'Runs rubocop against the cookbook, to enforce style and standards.'
task :rubocop do |t|
  puts '------------Rubocop-----------'
  system('rubocop -c rubocop.yml')
end

task :test => [:foodcritic]
desc 'Runs foodcritic rules against the cookbook'
task :foodcritic do |t|
  puts '------------Foodcritic-----------'
  system('foodcritic .')
end

# task :test => [:unit]
# desc 'Runs unit tests'
# RSpec::Core::RakeTask.new(:unit) do |t|
#   t.pattern = 'test/unit/**/*_spec.rb'
#   t.rspec_opts = '-fd'
# end



