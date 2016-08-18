terraform Cookbook CHANGELOG
============================

0.6.0
-----
- Update terraform to 0.7.0

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
