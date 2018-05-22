
# frozen_string_literal: true

#
# Cookbook Name:: terraform
# Recipe:: default
#
# Copyright 2014, Ross Timson
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "#{cookbook_name}::gpgme"

unless sig_verified?
  msg = "#{checksums_file} file cannot be trusted: gpg signature rejected"
  log msg do
    level :error
    notifies :delete, "remote_file[#{checksums_file}]"
  end
  raise
end
node.default['terraform']['checksums'] = raw_checksums_to_hash
node.default['terraform']['checksum'] =
  node['terraform']['checksums'][node['terraform']['zipfile']]

include_recipe 'ark'

ark 'terraform' do
  url terraform_url
  version node['terraform']['version']
  checksum node['terraform']['checksum']
  has_binaries ['terraform']
  append_env_path false
  strip_components 0

  if platform_family?('windows')
    win_install_dir node['terraform']['win_install_dir']
    owner node['terraform']['owner']
  end

  action :install
end

# update path
windows_path 'Windows install directory' do
  unless node['terraform']['win_install_dir'].nil?
    path node['terraform']['win_install_dir']
  end
  action :add
  only_if { platform_family?('windows') }
end
