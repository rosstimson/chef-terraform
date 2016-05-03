default['terraform']['url_base'] = 'https://releases.hashicorp.com/terraform'
default['terraform']['version'] = '0.6.11'
default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'
default['terraform']['zipfile'] = "terraform_%{version}_" \
  "#{node['os']}_#{node['terraform']['arch']}.zip"

# Windows attribute
if platform_family?('windows')
  default['terraform']['win_install_dir'] = 'C:\terraform'
  default['terraform']['owner'] = 'Administrator'
end
