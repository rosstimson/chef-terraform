
# frozen_string_literal: true

#
# Cookbook Name:: terraform
# Recipe:: gpgme
#
# Copyright 2016-2017, Dang Nguyen <haidangwa@gmail.com>
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

# this resource installs haveged for additional entropy
gpg_install 'gnupg2 and haveged'

hashicorp_keyfile = File.join(Dir.tmpdir, 'hashicorp.asc')

# deploy the hashicorp public key onto the target node
cookbook_file 'hashicorp.asc' do
  path hashicorp_keyfile
  mode '0644'
  notifies :import, 'gpg_key[import HashiCorp key to root keychain]',
           :immediately
end

gpg_key 'import HashiCorp key to root keychain' do
  user 'root'
  key_file hashicorp_keyfile
  name_real 'HashiCorp Security'
  action :import
end

# download the signature file and the raw checksums from Hashicorp
[sigfile, checksums_file].each do |file|
  remote_file file do
    path File.join(Dir.tmpdir, file)
    source "#{terraform_url_base}/#{file}"
    mode '0644'
  end
end
