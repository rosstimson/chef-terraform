node.default['terraform']['url_base'] = 'https://dl.bintray.com/mitchellh/terraform'
node.default['terraform']['version'] = '0.3.1'
node.default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'

# Transform raw output of the bintray checksum list into a Hash[filename, checksum].
# https://dl.bintray.com/mitchellh/terraform/${VERSION}_SHA256SUMS?direct
node.default['terraform']['raw_checksums'] = <<-EOF
  dda41425c7eb06c5e8b3f5ad4904e993aa8a9ab6b61f954ee2e259667cb6ff57 terraform_0.3.1_darwin_amd64.zip
  f773e9f75c055789e67dde80db4306d2f922cfa2f7b0d9c6413412778c594ffd terraform_0.3.1_linux_386.zip
  bd7b3e352a186010471818f8c50578e4afa9a2d2cf71acffb1810292db725e33 terraform_0.3.1_linux_amd64.zip
  e5ac6a68224e2a9b4774237cf37da39722239b1a058082fb830288c20691225a terraform_0.3.1_windows_386.zip
EOF
node.default['terraform']['checksums'] = Hash[
  node['terraform']['raw_checksums'].split("\n").map { |s| s.split.reverse }
]
filename = "#{node['terraform']['version']}_#{node['os']}_#{node['terraform']['arch']}.zip"
node.default['terraform']['checksum'] = node['terraform']['checksums'][filename]
