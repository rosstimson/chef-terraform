default['terraform']['url_base'] = 'https://dl.bintray.com/mitchellh/terraform'
default['terraform']['version'] = '0.6.7'
default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'
default['terraform']['zipfile'] = "terraform_#{node['terraform']['version']}_" \
  "#{node['os']}_#{node['terraform']['arch']}.zip"

# Transform raw output of the bintray checksum list into a Hash[filename, checksum].
# https://dl.bintray.com/mitchellh/terraform/${VERSION}_SHA256SUMS?direct
# rubocop:disable LineLength
default['terraform']['raw_checksums'] = <<-EOF
  fb7cf062b856e0ded770fd11856113568155954aa37ec46dfa854131b9ff7d0b  terraform_0.6.7_darwin_386.zip
  fe54fa09af11a1375a2b85912fe416d494a52137be7c5b0b4aaae35d75b0d588  terraform_0.6.7_darwin_amd64.zip
  5862129c4922e34b1672bc0dd7b088ce6091a616171aa7ba51e0714faea8549b  terraform_0.6.7_freebsd_386.zip
  2268c6dfca0c04618ba70e2db2da989d5adac3b7d1a3873e260ec512b20e2ee7  terraform_0.6.7_freebsd_amd64.zip
  712a8d65869c0eaf127d89823d03d3f217c54909f62bfd5fb829e6284170e09e  terraform_0.6.7_freebsd_arm.zip
  c12b89c42af88cebdfcfa00d8482e3c9b2ee09d419c09859423503f35def071a  terraform_0.6.7_linux_386.zip
  2e5de08f545e117eb9825b697c5ad290ee3fdcaae7d6de4b0e99830e58b38b2e  terraform_0.6.7_linux_amd64.zip
  e16349208eb372330aac5045739653fbbf371dc01ec16b85d064caeabbe1bb01  terraform_0.6.7_linux_arm.zip
  55eca01309e816796e34792c8eea9c0a08f3caa3b1d5034ecf1738d37ee34f2f  terraform_0.6.7_openbsd_386.zip
  1472437b677c08d24b1c325f69ef449bfbecd39906082a38039fada0ee4ee00c  terraform_0.6.7_openbsd_amd64.zip
  abf7bd57f143b2de902e4230980414c48fe96e0c2fcbad0fd91aeb2c98a0dbb8  terraform_0.6.7_windows_386.zip
  1447b66c032f71fc71014342f37e839a991ba796cfde77e74f62903bfef225c1  terraform_0.6.7_windows_amd64.zip
EOF
# rubocop:enable LineLength

default['terraform']['checksums'] = Hash[
  node['terraform']['raw_checksums'].split("\n").map { |s| s.split.reverse }
]
default['terraform']['checksum'] = node['terraform']['checksums'][node['terraform']['zipfile']]
