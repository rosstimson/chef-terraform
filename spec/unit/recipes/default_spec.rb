# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples'

describe 'terraform::default' do
  let(:terraform_version) { '0.11.7' }
  context 'ubuntu' do
    let(:sha256sum) do
      '6b8ce67647a59b2a3f70199c304abca0ddec0e49fd060944c26f666298e23418'
    end

    let(:checksums_file) { 'terraform_0.11.7_SHA256SUMS' }

    let(:checksums) do
      {
        'terraform_0.11.7_linux_amd64.zip' =>
          '6b8ce67647a59b2a3f70199c304abca0ddec0e49fd060944c26f666298e23418'
      }
    end

    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash)
          .and_return(checksums)
        allow(Chef::Recipe).to receive(:platform_family?).and_return('debian')
        allow(Chef::Resource).to receive(:signatures_trustworthy?)
          .and_return(true)
        # checksum for linux_amd64
        node.normal['terraform']['checksum'] = sha256sum
      end.converge(described_recipe)
    end

    it_behaves_like 'include_ark'
    it_behaves_like 'install_ark_terraform'

    context 'invalid gpg signatures' do
      it 'logs error' do
        allow(Chef::Resource).to receive(:signatures_trustworthy?)
          .and_return(false)
        rsrc = 'terraform_0.11.7_SHA256SUMS trust worthiness alert'
        expect(chef_run).to write_log(rsrc)
      end

      it 'ruby_block to raise does nothing' do
        rsrc = chef_run.ruby_block('raise if signature file cannot be trusted')
        expect(rsrc).to do_nothing
      end
      
      it 'triggers notifications due to bad signatures file' do
        log_name = "#{checksums_file} trust worthiness alert"
        resource = chef_run.log(log_name)
        notifications = [
          {
            notify: "remote_file[#{checksums_file}]",
            action: :delete
          },
          {
            notify: 'ruby_block[raise if signature file cannot be trusted]',
            action: :run
          }
        ]

        notifications.each do |notification|
          expect(resource).to notify(notification[:notify])
            .to(notification[:action]).immediately
        end
      end
    end
  end

  context 'windows' do
    let(:sha256sum) do
      '5fd003ef20f7a6a85ced4ad30bf95698afd4d0bfd477541583ff014e96026d6c'
    end

    let(:checksums) do
      {
        'terraform_0.11.7_windows_amd64.zip' =>
          '5fd003ef20f7a6a85ced4ad30bf95698afd4d0bfd477541583ff014e96026d6c'
      }
    end

    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'windows',
                                 version: '2012R2') do |node|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash)
          .and_return(checksums)
        allow(Chef::Recipe).to receive(:platform_family?).and_return('windows')
        allow(Chef::Resource).to receive(:signatures_trustworthy?)
          .and_return(true)
        node.normal['terraform']['checksum'] = sha256sum
        node.normal['terraform']['win_install_dir'] = 'C:\terraform'
      end.converge(described_recipe)
    end

    it_behaves_like 'include_ark'
    it_behaves_like 'install_ark_terraform'

    it 'created windows install dir' do
      expect(chef_run).to add_windows_path('Windows install directory')
        .with(path: 'C:\terraform')
    end
  end
end
