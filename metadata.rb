name             'rhsm'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rhsm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports "redhat"

recipe 'rhsm::default', 'Register instance and add code to unregister at shutdown'
recipe 'rhsm::register', 'Register instance'
recipe 'rhsm::unregister', 'Unregister instance'

attribute 'rhsm/rhel_username',
  :display_name => 'RedHat Account Username',
  :description => 'RedHat Account Username',
  :required => 'optional',
  :recipes => ['rhsm::default', 'rhsm::register']

attribute 'rhsm/rhel_password',
  :display_name => 'RedHat Account Password',
  :description => 'RedHat Account Password',
  :required => 'optional',
  :recipes => ['rhsm::default', 'rhsm::register']
