default['terraform']['url_base'] = 'https://releases.hashicorp.com/terraform'
default['terraform']['version'] = '0.8.2'
default['terraform']['arch'] = if node['kernel']['machine'] =~ /x86_64/
                                 'amd64'
                               else
                                 '386'
                               end

default['terraform']['zipfile'] = "terraform_#{node['terraform']['version']}_" \
  "#{node['os']}_#{node['terraform']['arch']}.zip"

# Windows attribute
if platform_family?('windows')
  default['terraform']['win_install_dir'] = 'C:\terraform'
  default['terraform']['owner'] = 'Administrator'
end
