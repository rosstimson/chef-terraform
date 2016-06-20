# Encoding: utf-8

require_relative 'spec_helper'

describe 'terraform::default' do
  context 'ubuntu' do
    let(:ubuntu_run) do
      ChefSpec::ServerRunner.new do |node, server|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash).and_call_original
        allow(Chef::Recipe).to receive(:platform_family?).and_return('ubuntu')
        node.set['terraform']['version'] = '0.6.16'
        node.set['terraform']['zipfile'] = 'terraform_0.6.16_linux_amd64.zip'
        node.set['terraform']['checksum'] = \
          'e10987bca7ec15301bc2fd152795d51cfc9fdbe6c70c9708e6e2ed81eaa1f082'
      end.converge(described_recipe)
    end

    it 'included ark recipe' do
      expect(ubuntu_run).to include_recipe('ark')
    end

    it 'installed terraform' do
      expect(ubuntu_run).to install_ark('terraform').with(
        version: '0.6.16',
        checksum: \
          'e10987bca7ec15301bc2fd152795d51cfc9fdbe6c70c9708e6e2ed81eaa1f082',
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
        node.set['terraform']['version'] = '0.6.16'
        node.set['terraform']['zipfile'] = 'terraform_0.6.16_windows_amd64.zip'
        node.set['terraform']['checksum'] = \
          '6acbc7e7025104d265cbfee982e5e7af0427255fa70bafa5bcbc595b56c6cce7'
        node.set['terraform']['win_install_dir'] = 'C:\terraform'
      end.converge(described_recipe)
    end

    it 'installed terraform' do
      expect(win_run).to install_ark('terraform').with(
        version: '0.6.16',
        checksum: \
          '6acbc7e7025104d265cbfee982e5e7af0427255fa70bafa5bcbc595b56c6cce7',
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
