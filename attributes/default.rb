default['terraform']['url_base'] = 'https://releases.hashicorp.com/terraform'
default['terraform']['version'] = '0.6.11'
default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'
default['terraform']['zipfile'] = "terraform_#{node['terraform']['version']}_" \
  "#{node['os']}_#{node['terraform']['arch']}.zip"

# Windows attribute
if platform_family?('windows')
  default['terraform']['win_install_dir'] = 'C:\terraform'
  default['terraform']['owner'] = 'Administrator'
end

# Transform raw output of the checksum list into a Hash[filename, checksum].
# https://releases.hashicorp.com/terraform/0.6.11/terraform_0.6.11_SHA256SUMS
default['terraform']['raw_checksums'] = <<-EOF
  cef10c71b7337cfe85c895a0a42d4f512c99f7944a06102b578f73aba32b45a7  terraform_0.6.11_darwin_386.zip
  9802b1d56576bea86e34fd3800e100eb043ab6de5a5fa40f7f05a0a44f364dd2  terraform_0.6.11_darwin_amd64.zip
  2eb8079176fd173803e06159c1901707b00045dff4e5ea175166bcc957726733  terraform_0.6.11_freebsd_386.zip
  a8d28c82dfa9e0f6503b6c2a840d8e373f9cf54437db08d935be92152719ba07  terraform_0.6.11_freebsd_amd64.zip
  2806bbadfe70139f60beeda381b2976f75ce8682eaef294b77fcbeeb332e2d02  terraform_0.6.11_freebsd_arm.zip
  8b3bf0e1ac3180f3846abea9bfb3a30eb098460f7923989b5eb4bb8cd4ae80fc  terraform_0.6.11_linux_386.zip
  f451411db521fc4d22c9fe0c80105cf028eb8df0639bac7c1e781880353d9a5f  terraform_0.6.11_linux_amd64.zip
  7a906ea4137f590afd650aae4bc121e52ae40d5a7f7e57a2ba5c0c3bd316768c  terraform_0.6.11_linux_arm.zip
  9f04586b066c7a3496e07aaafb1dd1bb470e049ad812657f1c1c59259be69a93  terraform_0.6.11_openbsd_386.zip
  a57fbcff72ad17c3261b272b4fc9ae15e059ff186d4aa9064ada43613ada3f23  terraform_0.6.11_openbsd_amd64.zip
  0738fad4fc55d0120d4bc0ff47fb57a45376a45cf7d8f939c03e5becb97f30cd  terraform_0.6.11_solaris_amd64.zip
  8564488b4a8e8e40d37c63424006315b89c13096357411a21ce84f26ec92767f  terraform_0.6.11_windows_386.zip
  4832e6ca2b60bb3d08ef69497bc11890d3e986f0ce76d20bed1a2e9520fc93ba  terraform_0.6.11_windows_amd64.zip
EOF

default['terraform']['checksums'] = Hash[
  node['terraform']['raw_checksums'].split("\n").map { |s| s.split.reverse }
]
default['terraform']['checksum'] = node['terraform']['checksums'][node['terraform']['zipfile']]
