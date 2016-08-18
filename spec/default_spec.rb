# Encoding: utf-8

require_relative 'spec_helper'

describe 'terraform::default' do
  context 'ubuntu' do
    let(:ubuntu_run) do
      ChefSpec::ServerRunner.new do |node, server|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash).and_call_original
        allow(Chef::Recipe).to receive(:platform_family?).and_return('ubuntu')
        node.set['terraform']['version'] = '0.7.0'
        node.set['terraform']['zipfile'] = 'terraform_0.7.0_linux_amd64.zip'
        node.set['terraform']['checksum'] = \
          'a196c63b967967343f3ae9bb18ce324a18b27690e2d105e1f38c5a2d7c02038d'
      end.converge(described_recipe)
    end

    it 'included ark recipe' do
      expect(ubuntu_run).to include_recipe('ark')
    end

    it 'installed terraform' do
      expect(ubuntu_run).to install_ark('terraform').with(
        version: '0.7.0',
        checksum: \
          'a196c63b967967343f3ae9bb18ce324a18b27690e2d105e1f38c5a2d7c02038d',
        has_binaries: ['terraform'],
        append_env_path: false,
        strip_components: 0
      )
    end
  end

  context 'windows' do
    let(:win_run) do
      ChefSpec::ServerRunner.new( platform: 'windows',
                                  version: '2012R2') do |node, server|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash).and_call_original
        allow(Chef::Recipe).to receive(:platform_family?).and_return('windows')
        node.set['terraform']['version'] = '0.7.0'
        node.set['terraform']['zipfile'] = 'terraform_0.7.0_windows_amd64.zip'
        node.set['terraform']['checksum'] = \
          'c891dffeb8f82e1b96c8d2e9777158b99442754866a876fdeffed3557651bcc3'
        node.set['terraform']['win_install_dir'] = 'C:\terraform'
      end.converge(described_recipe)
    end

    it 'installed terraform' do
      expect(win_run).to install_ark('terraform').with(
        version: '0.7.0',
        checksum: \
          'c891dffeb8f82e1b96c8d2e9777158b99442754866a876fdeffed3557651bcc3',
        has_binaries: ['terraform'],
        append_env_path: false,
        strip_components: 0,
        win_install_dir: 'C:\terraform',
        owner: 'Administrator'
      )
    end

    it 'created windows install dir' do
      expect(win_run).to add_windows_path('C:\terraform')
    end
  end
end
