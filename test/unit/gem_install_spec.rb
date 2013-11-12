require_relative './spec_helper.rb'

RSpec.configure do |c|
  include ServerSpecHelper

  c.before :all do
    setup_serverspec_vagrant_ssh(c)
  end
end



describe 'the VM should get the chef-attribute-validation gem' do
  describe file('/opt/chef/embedded/lib/ruby/gems/1.9.1/gems/chef-attribute-validator-0.2.0') do
    it {should be_directory }
  end
end
