# Encoding: utf-8

require_relative 'spec_helper'

describe 'terraform::default' do
  describe command('terraform version') do
    its(:exit_status) { should eq 0 }
    # Discrepancy in version due to a known Terraform issue:
    # https://github.com/hashicorp/terraform/issues/2067
    its(:stdout) { should match(/Terraform v0\.5\.2/) }
  end

  describe file('/usr/local/terraform-0.5.1') do
    it { should be_owned_by 'root' }
  end

  describe file('/usr/local/terraform') do
    it { should be_linked_to '/usr/local/terraform-0.5.1' }
    it { should be_owned_by 'root' }
  end

  describe file('/usr/local/bin/terraform') do
    it { should be_linked_to '/usr/local/terraform-0.5.1/terraform' }
    it { should be_owned_by 'root' }
    it { should be_executable }
  end
end
