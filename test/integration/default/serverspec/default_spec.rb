# Encoding: utf-8

require_relative 'spec_helper'

describe 'terraform::default' do
  describe command('terraform -v') do
    it { should return_exit_status 0 }
    it { should return_stdout 'Terraform v0.1.0' }
  end

  describe file('/usr/local/terraform-0.1.0') do
    it { should be_owned_by 'root' }
  end

  describe file('/usr/local/terraform') do
    it { should be_linked_to '/usr/local/terraform-0.1.0' }
    it { should be_owned_by 'root' }
  end

  describe file('/usr/local/bin/terraform') do
    it { should be_linked_to '/usr/local/terraform-0.1.0/terraform' }
    it { should be_owned_by 'root' }
    it { should be_executable }
  end
end
