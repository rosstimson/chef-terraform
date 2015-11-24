default['terraform']['url_base'] = 'https://dl.bintray.com/mitchellh/terraform'
default['terraform']['version'] = '0.5.1'
default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'
default['terraform']['zipfile'] = "terraform_#{node['terraform']['version']}_" \
  "#{node['os']}_#{node['terraform']['arch']}.zip"

# Transform raw output of the bintray checksum list into a Hash[filename, checksum].
# https://dl.bintray.com/mitchellh/terraform/${VERSION}_SHA256SUMS?direct
# rubocop:disable LineLength
default['terraform']['raw_checksums'] = <<-EOF
  191a4150c86f9b12d922e3300a5dc884f3fcfcbf0158d3c3a9d2c82e8738037b  terraform_0.5.1_darwin_386.zip
  5915d7668b07ea3770f1bc8126764f90723eade0245e0634af3b051ae2ceb7e5  terraform_0.5.1_darwin_amd64.zip
  c60f23cafd309faddb592adf42a85a8b672f8d88c050a1cf8d8365c5939d0744  terraform_0.5.1_freebsd_386.zip
  5c84d810a5e2d813ed299650cb1b3e91210a1d189a08e8c531d4cd9d5e948ed8  terraform_0.5.1_freebsd_amd64.zip
  87e8c4d758be1f040ce902952ef7f30330c34efde798282b230e8f8ab05f0d9b  terraform_0.5.1_freebsd_arm.zip
  97d80d595c87387205a84a4140eae6e85ca784abb7ba88b7f5cef2b7c90f377b  terraform_0.5.1_linux_386.zip
  5f651ffd0f8d7386ed5d44d50ef0053ee974d1a73bb9becf7c99c886615a98f7  terraform_0.5.1_linux_amd64.zip
  d28d10b1d08e8d525963dbc662ed0071f34d5133bcc8397240e5666ad38eee9c  terraform_0.5.1_linux_arm.zip
  559562e2dd1774ea95d981acba11b8c5f47a3078aafe90e194848b9834017123  terraform_0.5.1_openbsd_386.zip
  0e7b1b2f43411c3f950cdb82945bfa70b37e835e4c510462b720c7cac4c0ccc2  terraform_0.5.1_openbsd_amd64.zip
  927a556566ed4c3cc9a2c64015927bf9038aa6892258451fdf9d99791a2889a5  terraform_0.5.1_windows_386.zip
  fb0b9a1c15252c33fcc523ccf9cddaecc76ef122a129a0badea4b2817512c279  terraform_0.5.1_windows_amd64.zip
EOF
# rubocop:enable LineLength

default['terraform']['checksums'] = Hash[
  node['terraform']['raw_checksums'].split("\n").map { |s| s.split.reverse }
]
default['terraform']['checksum'] = node['terraform']['checksums'][node['terraform']['zipfile']]
