default['terraform']['url_base'] = 'https://releases.hashicorp.com/terraform'
default['terraform']['version'] = '0.8.2'
default['terraform']['arch'] = if node['kernel']['machine'] =~ /x86_64/
                                 'amd64'
                               else
                                 '386'
                               end

# Windows attributes
default['terraform']['win_install_dir'] = 'C:\terraform'
default['terraform']['owner'] = 'Administrator'
