# frozen_string_literal: true

default['terraform']['url_base'] = 'https://releases.hashicorp.com/terraform'
default['terraform']['version'] = '0.11.7'
default['terraform']['arch'] = if node['kernel']['machine'].match?(/x86_64/)
                                 'amd64'
                               else
                                 '386'
                               end

default['terraform']['zipfile'] = "terraform_#{node['terraform']['version']}_" \
  "#{node['os']}_#{node['terraform']['arch']}.zip"

# Windows attributes
default['terraform']['win_install_dir'] = 'C:\terraform'
default['terraform']['owner'] = 'Administrator'
