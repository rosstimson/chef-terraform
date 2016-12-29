# Encoding: utf-8
#
# Cookbook Name:: terraform
# Recipe:: gpgme
#
# Copyright 2016, Dang Nguyen <haidangwa@gmail.com>
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
require 'tmpdir'

node.default['build-essential']['compile_time'] = true
include_recipe 'build-essential'

cookbook_file File.join(Dir.tmpdir, 'hashicorp.asc') do
  mode 644
  action :nothing
end.run_action(:create)

chef_gem 'gpgme' do
  compile_time true if respond_to?(:compile_time)
end

require 'gpgme'
import_gpg_key
