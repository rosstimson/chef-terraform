require_relative 'support/test_helper'

describe_recipe 'terraform::default' do
  include ChefTerraform::TestHelper

  it 'installed terraform' do
    skip 'not tested under Windows' if platform_family?('windows')
    terraform_dir = "/usr/local/terraform-#{node['terraform']['version']}"
    directory(terraform_dir)
      .must_exist
      .and(:owner, 'root')
      .and(:group, 'root')
    link('/usr/local/terraform')
      .must_exist
      .with(:to, terraform_dir)
    link('/usr/local/bin/terraform')
      .must_exist
      .with(:to, File.join(terraform_dir, 'terraform'))
    file(File.join(terraform_dir, 'terraform'))
      .must_exist
  end
end
