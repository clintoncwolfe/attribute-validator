require 'serverspec'
require 'pathname'
require 'net/ssh'

include Serverspec::Helper::Exec
include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

module ServerSpecHelper
  def setup_serverspec_vagrant_ssh(rspec_conf)

    rspec_conf.sudo_password = ENV['SUDO_PASSWORD']
    
    # Guess hostname from file location
    block = self.class.metadata[:example_group_block]
    file = block.source_location.first
    host  = File.basename(Pathname.new(file).dirname)

    # Reconnect to VM using Vagrant credentials if it is a different hostname
    if rspec_conf.host != host # TODO: this is always false, slowwwww tests :(
      rspec_conf.ssh.close if rspec_conf.ssh
      rspec_conf.host  = host
      options = Net::SSH::Config.for(rspec_conf.host)
      user    = options[:user] || Etc.getlogin
      `vagrant up default`
      config = `vagrant ssh-config default`
      if config != ''
        # Disabling AssignmentInCondition here because we are doing regex 
        # matches, whose result is both testable and needed.
        # rubocop:disable AssignmentInCondition
        config.each_line do |line|
          if match = /HostName (.*)/.match(line)  
            rspec_conf.host = match[1]
          elsif  match = /User (.*)/.match(line)
            user = match[1]
          elsif match = /IdentityFile (.*)/.match(line)
            options[:keys] =  [match[1].gsub(/"/, '')]
          elsif match = /Port (.*)/.match(line)
            options[:port] = match[1]
          end
        end
        # rubocop:enable AssignmentInCondition
      end
      rspec_conf.ssh   = Net::SSH.start(rspec_conf.host, user, options)
    end
  end
end

