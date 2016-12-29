
# **NOTE** This file should be required from *inside* of a describe_recipe
# block. Doing it globally at the top of a test file has been seen to cause
# issues
require 'minitest/spec'
require 'minitest-chef-handler'

# this module starts Chef-Terraform
module ChefTerraform
  # test helper module under chef-terraform
  module TestHelper
    # This module is intended to be included form test cases to help reduce
    # duplication of includes
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    include Terraform::Helpers
    MiniTest::Chef::Resources.register_resource(:gem_package)
    MiniTest::Chef::Resources.register_resource(:chef_gem)
  end
end
