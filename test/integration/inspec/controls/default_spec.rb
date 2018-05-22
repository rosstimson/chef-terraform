# frozen_string_literal: true

version = '0.11.7'

control 'terraform cookbook default' do
  title 'Default recipe'
  impact 0.9
  only_if { !os.windows? }

  terraform_dir = "/usr/local/terraform-#{version}"
  describe directory(terraform_dir) do
    it { should be_directory }
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe directory('/usr/local/terraform') do
    its('link_path') { should eq terraform_dir }
  end

  describe file('/usr/local/bin/terraform') do
    its('link_path') { should eq File.join(terraform_dir, 'terraform') }
  end

  describe file(File.join(terraform_dir, 'terraform')) do
    it { should exist }
    it { should be_file }
  end
end
