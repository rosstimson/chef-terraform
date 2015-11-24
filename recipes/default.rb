# Encoding: utf-8
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

include_recipe 'ark'

ark 'terraform' do
  url "#{node['terraform']['url_base']}/#{node['terraform']['zipfile']}"
  version node['terraform']['version']
  checksum node['terraform']['checksum']
  has_binaries ['terraform']
  append_env_path false
  strip_leading_dir false
  strip_components 0

  action :install
end
