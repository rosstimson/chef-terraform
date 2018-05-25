terraform Cookbook CHANGELOG
============================


2.0.2
-----
- Added CONTRIBUTING.md
- Added TESTING.md
- Removed helper methods obsoleted by gpg cookbook:
  - `#import_gpg_key`
  - `#key_imported?`
- `#sig_verified?` aliased to `#signature_trustworthy`
- ensure gnupg2 is installed
- Removed gpgme gem dependency
- Removed explicit build-essential cookbook dependency from metadta
  - ark lists build-essential as a dependency

2.0.1
-----
- Fixed Debian and centos 7 vagrant test images
- Fixed [#28](https://github.com/rosstimson/chef-terraform/issues/28)
  bumped ark dependency to `~> 3.1`
- Fixed [#29](https://github.com/rosstimson/chef-terraform/issues/29)
  run GPG-related procedures at converge time instead of compile time

2.0.0
-----
- Now requires Chef 13 or newer
- Use vagrant images hosted at https://app.vagrantup.com/bento
- Added testing with Chef 13 and 14
- Ported minitests to Inspec
- Changed default terraform version to 0.11.7

1.0.2
-----
- (Grasshopper): updated build-essential version dependency

1.0.1
-----
- update to handle new host folder structure at terraform
- updated to use fedora-25 image during testing
- updated to use debian 8.6 image during testing
- replaced ubuntu 16.04 vagrant image with ubuntu 16.10 image
- added ubuntu 15.10 vagrant image
- use chef_gem assertion of gpgme gem in minitest instead of gem_package
- removed windows config from Test Kitchen
- official testing of Windows platform removed (never worked before, anyway)

1.0.0
-----
- update ark dependency: ~> 2.0 (Now requires Chef 12.5+)
- update bundler gems
- added winrm transport gems: requires vagrant-winrm Vagrant plugin. Please install this plugin with: `vagrant plugin install vagrant-winrm'
- Set default terraform version to 0.8.2
- Added recipe: terraform::gpgme to install gpgme
- Added helper method, `#sig_verified?` that will verify the gpg signature
  of the checksum file and abort if the signature is rejected.

0.5.3
-----
redeploy to supermarket with --extended-metadata option

0.5.2
-----
- no code changes: merged https://github.com/rosstimson/chef-terraform/pull/22

0.5.1
-----
- Documentation update

0.5.0
-----
- Update terraform to 0.6.16
- Update ark dependency to '~> 1.1.0'

0.4.4
-----
- added chefspec tests
- added more test platforms in Test Kitchen
- Merged PR #16 that resolves derived attribute issue

0.4.3
-----
- Patch a bug introduced by v0.4.2 where the URI.join truncated any path from the URI base.
  This resulted in GET requests that were missing whatever path was included in the URL base, such
  as "/terraform"

0.4.2
-----
- Remove extraneous slashes from Terraform's SHA256SUMS URL that give 403 Forbidden

0.4.1
-----
- cleaned up the fetch_checksums helper method
- set the default['terraform']['checksums'] and default['terraform']['checksum']
  attributes in the default recipe

0.4.0
-----
- Add helper methods: raw_checksums_to_hash, fetch_checksums, terraform_url
- Fixed Issue #10(https://github.com/rosstimson/chef-terraform/issues/10)

0.3.0
-----
- Fixed rubocop offenses
- updated serverspec to test against Terraform 0.6.11 install paths
- Added minitest handler dependency for Test Kitchen runs
- Added minitest test suites
- Fixed Issue #11(https://github.com/rosstimson/chef-terraform/issues/11)

0.2.1
-----
- Buump Terraform to latest version (0.6.11) (@thegreenrobot)

0.2.0
-----
- Fixed Issue #6(https://github.com/rosstimson/chef-terraform/issues/6)
  set the terraform zip file name in a node attribute (@haidangwa)
- Updated the default version to 0.6.8
- Fixed the download link as no longer using Bintray
- Windows support (@ridiculousness)

0.1.3
-----
- Fixed Issue #6(https://github.com/rosstimson/chef-terraform/issues/6)
  set the terraform zip file name in a node attribute
- updated the default version to 0.6.7

0.1.2
-----

- Update to Terraform 0.5.1 (@wilb)
- Fixing rsync trailing slash issue. (@dquiles)

0.1.1
-----

- Update to Terraform 0.3.1 (@cantenesse)
- Kills hard dependency on Ark cookbook (@cantenesse)

0.1.0
-----
- Initial release.
