# Encoding: utf-8

require_relative 'spec_helper'

describe 'terraform::default' do
  context 'ubuntu' do
    let(:ubuntu_run) do
      ChefSpec::ServerRunner.new do |node, server|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash).and_call_original
        allow(Chef::Recipe).to receive(:platform_family?).and_return('ubuntu')
        node.set['terraform']['version'] = '0.6.11'
        node.set['terraform']['zipfile'] = 'terraform_0.6.11_linux_amd64.zip'
        node.set['terraform']['checksum'] = \
          'f451411db521fc4d22c9fe0c80105cf028eb8df0639bac7c1e781880353d9a5f'
      end.converge(described_recipe)
    end

    it 'included ark recipe' do
      expect(ubuntu_run).to include_recipe('ark')
    end

    it 'installed terraform' do
      expect(ubuntu_run).to install_ark('terraform').with(
        version: '0.6.11',
        checksum: \
          'f451411db521fc4d22c9fe0c80105cf028eb8df0639bac7c1e781880353d9a5f',
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
        node.set['terraform']['version'] = '0.6.11'
        node.set['terraform']['zipfile'] = 'terraform_0.6.11_windows_amd64.zip'
        node.set['terraform']['checksum'] = \
          '4832e6ca2b60bb3d08ef69497bc11890d3e986f0ce76d20bed1a2e9520fc93ba'
        node.set['terraform']['win_install_dir'] = 'C:\terraform'
      end.converge(described_recipe)
    end

    it 'installed terraform' do
      expect(win_run).to install_ark('terraform').with(
        version: '0.6.11',
        checksum: \
          '4832e6ca2b60bb3d08ef69497bc11890d3e986f0ce76d20bed1a2e9520fc93ba',
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
