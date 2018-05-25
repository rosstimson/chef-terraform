terraform Cookbook
==================

Installs [Terraform][terraform] by HashiCorp.

[Terraform][terraform] is an open source tool that allows you to
configure entire infrastructure stack as code.

Requirements
------------
### Chef Client
As of version 2.0.0, this cookbook will require minimum chef-client 13

### Cookbooks

This cookbook depends on the [ark cookbook](https://supermarket.getchef.com/cookbooks/ark)
to unpackage and install terraform.

** GPG **
As of this writing (5/24/18), the community gpg cookbook that is released in Supermarket was transferred to the sous-chef group for ownership. However, the features that this cookbook relies on is not yet published. Therefore, if you run this cookbook, be sure to use berkshelf to ensure that the correct cookbook dependencies are uploaded to your chef org.

If you see the error below, it is a result of using the published 0.3.0 version of gpg from supermarket.chef.io and not the github referenced commit.

```
================================================================================
Recipe Compile Error in /tmp/kitchen/cache/cookbooks/terraform/recipes/default.rb
================================================================================

NoMethodError
-------------
undefined method `gpg_install' for cookbook: terraform, recipe: gpgme :Chef::Recipe

Cookbook Trace:
---------------
  /tmp/kitchen/cache/cookbooks/terraform/recipes/gpgme.rb:34:in `from_file'
  /tmp/kitchen/cache/cookbooks/terraform/recipes/default.rb:23:in `from_file'

Relevant File Content:
----------------------
/tmp/kitchen/cache/cookbooks/terraform/recipes/gpgme.rb:


 34>> gpg_install 'gnupg2 and haveged'
 35:  
```

This cookbook's Berksfile contains this reference to the current version of gpg in github:
```
cookbook 'gpg', git: 'https://github.com/sous-chefs/gpg',
         ref: '2f682a1406047e99351d184fe18fff035a0c856c'
```

### Platforms

The following platforms are supported and have been tested under
[Test Kitchen][testkitchen]:

* CentOS 6.9
* CentOS 7.4
* Debian 8.6
* Fedora 27
* Ubuntu 16.04
* Ubuntu 18.04

Other versions of these OSs should work. Alternative Debian and RHEL
family distributions are also assumed to work. Please [report][issues]
any additional platforms you have tested so they can be added.

** Note for Debian:
[dayne](https://github.com/dayne) has found that this cookbook may not converge on Debian platforms. This can be fixed by doing running `apt update`, and then it will converge. This workaround has been applied to Test Kitchen by invoking the `terraform_test::ubuntu` recipe.

Usage
-----

Simply include `recipe[terraform]` in your run_list to have
[Terraform][terraform] installed. If you are using an artifact repository, like Nexus, hosted behind your corporate firewall, you must set the default attribute or override attributes in your roles or environments. The attributes are detailed velow.

Recipes
-------

### default

Installs [Terraform][terraform] from official pre-compiled binaries and gnupg with the gpgme recipe, below.


### gpgme

Installs gnupg2 and haveged to ensure the checksums file from HashiCorp can be trusted. This recipe is included when the default recipe is added to your node's run list.


Attributes
----------

### `node['terraform']['url_base']`

If you are using an artifact repository, like Nexus, hosted behind your corporate firewall, you must set the default attribute or override attributes in your roles or environments.

Default: https://releases.hashicorp.com/terraform


### `node['terraform']['version']`

The version of [Terraform][terraform] that will be installed (Default: 0.11.7)

### `node['terraform']['checksum']`

_As of v0.4.1, checksums are processed dynamically. There is no longer a need to specify the sha256 checksums of each terraform package in a cookbook attribute manually_

_As of v1.0.0, the checksum file will have its gpg signature verified. If the gpg signature is rejected, the chef run will fail.

_NOTE: All other attributes are considered internal and shouldn't
normally need to be changed._


#### Example setting default_attributes in a role (JSON file):

```json
{
  "name": "terraform_workstation",
  "description": "Role to apply onto a terraform workstation",
  "json_class": "Chef::Role",
  "default_attributes": {
    "terraform": {
      "url_base": "https://nexus.internal.com/nexus",
      "version": "0.11.7"
    }
  },
  "override_attributes": {},
  "run_list": [
    "recipe[terraform]"
  ]
}
```


Development
-----------

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]


### Credit

This cookbook, especially the checksum stuff in
attributes file has been influenced by the [Packer
cookbook](https://supermarket.getchef.com/cookbooks/packer) by
[@sit](https://github.com/sit).

### License and Author

Author:: [Ross Timson][rosstimson]
<[ross@rosstimson.com](mailto:ross@rosstimson.com)>

Contributor:: [Dang Nguyen][haidangwa]
<[haidangwa@gmail.com](mailto:haidangwa@gmail.com)>

Copyright 2014, Ross Timson

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


[rosstimson]:         https://github.com/rosstimson
[haidangwa]:          https://github.com/haidangwa
[repo]:               https://github.com/rosstimson/chef-terraform
[issues]:             https://github.com/rosstimson/chef-terraform/issues
[terraform]:          http://www.terraform.io
[chefspec]:           https://github.com/sethvargo/chefspec
[foodcritic]:         https://github.com/acrmp/foodcritic
[rubocop]:            https://github.com/bbatsov/rubocop
[inspec]:             https://www.inspec.io/
[testkitchen]:        https://github.com/test-kitchen/test-kitchen
[ruby-gpgme]:         https://github.com/ueno/ruby-gpgme
