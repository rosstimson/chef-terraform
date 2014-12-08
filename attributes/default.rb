node.default['terraform']['url_base'] = 'https://dl.bintray.com/mitchellh/terraform'
node.default['terraform']['version'] = '0.3.1'
node.default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'

# Transform raw output of the bintray checksum list into a Hash[filename, checksum].
# https://dl.bintray.com/mitchellh/terraform/${VERSION}_SHA256SUMS?direct
node.default['terraform']['raw_checksums'] = <<-EOF
  f4a42243abb2b3d6fde815f43480217982bc676f0510c46c05f544546c4d2d89  terraform_0.3.1_darwin_386.zip
  dda41425c7eb06c5e8b3f5ad4904e993aa8a9ab6b61f954ee2e259667cb6ff57  terraform_0.3.1_darwin_amd64.zip
  a3751daa08f0e30087d1ce58cc4200d30d647e8687fc6d285f57d5f5e6d61aaf  terraform_0.3.1_freebsd_386.zip
  d1a54b62edd9e575dda3b1ff91fdf22c5aed380e04807228dd4bab8d54b81ba8  terraform_0.3.1_freebsd_amd64.zip
  084427ce689b5070ec168009d7e296aa2fd69423bf2d8bf9acb1cd502a01d828  terraform_0.3.1_freebsd_arm.zip
  f773e9f75c055789e67dde80db4306d2f922cfa2f7b0d9c6413412778c594ffd  terraform_0.3.1_linux_386.zip
  bd7b3e352a186010471818f8c50578e4afa9a2d2cf71acffb1810292db725e33  terraform_0.3.1_linux_amd64.zip
  8f742a7753cb5ed48e7dd04dec4875b107265c82bfe9df1e362012aa6cd60839  terraform_0.3.1_linux_arm.zip
  a6001660534adf695923cb1e9a4fb85134472c9b59af4ca0bed7e4991e7763f0  terraform_0.3.1_openbsd_386.zip
  0adf2e37a3b30ab2b0665b0cb30721fd9fe97566aa4e65c4b5928910d40e5e0a  terraform_0.3.1_openbsd_amd64.zip
  e5ac6a68224e2a9b4774237cf37da39722239b1a058082fb830288c20691225a  terraform_0.3.1_windows_386.zip
  76ff60d10fe74556d7d20c557c15e853c5900036cf14576584a459fd84c78e30  terraform_0.3.1_windows_amd64.zip
EOF
node.default['terraform']['checksums'] = Hash[
  node['terraform']['raw_checksums'].split("\n").map { |s| s.split.reverse }
]
filename = "terraform_#{node['terraform']['version']}_#{node['os']}_#{node['terraform']['arch']}.zip"
node.default['terraform']['checksum'] = node['terraform']['checksums'][filename]
