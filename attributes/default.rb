node.default['terraform']['url_base'] = 'https://dl.bintray.com/mitchellh/terraform'
node.default['terraform']['version'] = '0.1.0'
node.default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'

# Transform raw output of the bintray checksum list into a Hash[filename, checksum].
# https://dl.bintray.com/mitchellh/terraform/${VERSION}_SHA256SUMS?direct
node.default['terraform']['raw_checksums'] = <<-EOF
  309aed0ed61586e2682f58b77781f8e9805745a5edd1aebcddf883c9f624a0b9 0.1.0_darwin_amd64.zip
  7925b3f1f759074c521dce21f836405f1b88347adf45233591a1d8f1a4985460 0.1.0_linux_386.zip
  f9236171f522c9bd1c99c9f5e0ecde7f8ba881afd9f5aef8f70bdeb0a209fc22 0.1.0_linux_amd64.zip
  ab7393f86fad7f870d398aed6984c88001b7cc36366973489cf46701dc90cf3e 0.1.0_windows_386.zip
EOF
node.default['terraform']['checksums'] = Hash[
  node['terraform']['raw_checksums'].split("\n").collect { |s| s.split.reverse }
]
filename = "#{node['terraform']['version']}_#{node['os']}_#{node['terraform']['arch']}.zip"
node.default['terraform']['checksum'] = node['terraform']['checksums'][filename]
