
# frozen_string_literal: true

name             'terraform'
maintainer       'Ross Timson'
maintainer_email 'ross@rosstimson.com'
license          'Apache-2.0'
description      'Installs Terraform (terraform.io)'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.1'

depends 'ark', '~> 3.1'
depends 'build-essential', '~> 8.0'

supports 'centos', '> 6.0'
supports 'debian', '> 7.0'
supports 'redhat', '> 6.0'
supports 'ubuntu', '>= 14.04'

source_url 'https://github.com/rosstimson/chef-terraform'
issues_url 'https://github.com/rosstimson/chef-terraform/issues'
chef_version '> 13.0'
