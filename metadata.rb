# Encoding: utf-8
name             'terraform'
maintainer       'Ross Timson'
maintainer_email 'ross@rosstimson.com'
license          'Apache 2.0'
description      'Installs Terraform (terraform.io)'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.3'

depends          'ark', '~> 1.0.0'

%w( centos debian fedora ubuntu windows ).each do |os|
  supports os
end
