default['terraform']['url_base'] = 'https://releases.hashicorp.com/terraform'
default['terraform']['version'] = '0.6.8'
default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'
default['terraform']['zipfile'] = "terraform_#{node['terraform']['version']}_" \
  "#{node['os']}_#{node['terraform']['arch']}.zip"

# Windows attribute
if platform_family?('windows')
  default['terraform']['win_install_dir'] = 'C:\terraform'
  default['terraform']['owner'] = 'Administrator'
end

# Transform raw output of the checksum list into a Hash[filename, checksum].
# https://releases.hashicorp.com/terraform/0.6.8/terraform_0.6.8_SHA256SUMS
# rubocop:disable LineLength
default['terraform']['raw_checksums'] = <<-EOF
  74f9370b3464a64b7e080913375f3eb2b3510f072e1725d59a487a4468eb4179  terraform_0.6.8_darwin_386.zip
  71fd8ff20f657a4c7d82794756d55c55b0686516a8253356b8edd1a728230577  terraform_0.6.8_darwin_amd64.zip
  076ecb40dca75e9df78b2c99f363b45c6c52d61408e7824922fe090a748e0f76  terraform_0.6.8_freebsd_386.zip
  783f176a631b51ba7a39a534d554397a30d28a3873367dd31fe827911f14c7bd  terraform_0.6.8_freebsd_amd64.zip
  9679549e15bbd5c95b530498193de2db66552402efe450d44cb7c9984c9203c4  terraform_0.6.8_freebsd_arm.zip
  5260aba337b536e2dbee57f7df02b4b41dc3cb4610d8603590ae2d6ae5eec59b  terraform_0.6.8_linux_386.zip
  fd61718820c3f2334276517a89694cebe82db354b584ea90c376f1c6d34bb92d  terraform_0.6.8_linux_amd64.zip
  06ba5d99776d5bc1accce7817da4f0093a1871dba56cb0d797b962f919814904  terraform_0.6.8_linux_arm.zip
  dfbba500dfd628efd889bd11b58b09b9fd78e7c2a9351200d36f865688dddfc0  terraform_0.6.8_openbsd_386.zip
  6521d4123dbde3a96dc954f06bdc936811607daaa60badbd039a45bc87bcdc49  terraform_0.6.8_openbsd_amd64.zip
  4a2fbb7b5dd7ad6400f853f24db2860cafefdf319c87d559355121cd180739d4  terraform_0.6.8_windows_386.zip
  357dd1df7443fa1078747e123dd56abba793ebe47b3670556fb11a2547ad6750  terraform_0.6.8_windows_amd64.zip
EOF

default['terraform']['checksums'] = Hash[
  node['terraform']['raw_checksums'].split("\n").map { |s| s.split.reverse }
]
default['terraform']['checksum'] = node['terraform']['checksums'][node['terraform']['zipfile']]
