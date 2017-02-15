require_relative 'support/test_helper'

describe_recipe 'terraform::gpgme' do
  include ChefTerraform::TestHelper

  it 'imported Hashicorp public GPG key' do
    assert key_imported?
  end

  it 'checksums signature is accepted' do
    assert sig_verified?
  end

  it 'installed gpgme gem' do
    chef_gem('gpgme').must_be_installed
  end
end
