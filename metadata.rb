name             'attribute-validator'
maintainer       'Clinton Wolfe'
maintainer_email 'clinton@omniti.com'
license          'BSD (3-clause)'
description      'Enforces attribute validation rules using the chef-attribute-validator gem.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.4'

recipe 'install', 'Installs chef-attribute-validator gem to chef ruby gemstore'
recipe 'compile-time-check', 'Enforces attribute validation rules at compile time'
recipe 'converge-time-check', 'Enforces attribute validation rules at convergence time'


