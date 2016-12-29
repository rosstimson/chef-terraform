# Encoding: utf-8

require_relative 'spec_helper'

describe 'terraform::default' do
  let(:terraform_version) { '0.8.2' }
  context 'ubuntu' do
    let(:sha256sum) do
      'a366fd2d7d8908d23acc23ab151fc692615a147f8832971bb43e42995554c652'
    end

    let(:ubuntu_run) do
      ChefSpec::ServerRunner.new do |node|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash).and_call_original
        allow(Chef::Recipe).to receive(:platform_family?).and_return('ubuntu')
        # checksum for linux_amd64
        node.normal['terraform']['checksum'] = sha256sum
      end.converge(described_recipe)
    end

    it 'included ark recipe' do
      expect(ubuntu_run).to include_recipe('ark')
    end

    it 'installed terraform' do
      expect(ubuntu_run).to install_ark('terraform').with(
        version: terraform_version,
        checksum: sha256sum,
        has_binaries: ['terraform'],
        append_env_path: false,
        strip_components: 0
      )
    end
  end

  context 'windows' do
    let(:sha256sum) do
      'e1166534f77c89f742a5ae2549f2b9dfe2491bd36ba771ed2a88d5e16508e7e2'
    end

    let(:win_run) do
      ChefSpec::ServerRunner.new(platform: 'windows',
                                 version: '2012R2') do |node|
        allow(Chef::Recipe).to receive(:raw_checksums_to_hash).and_call_original
        allow(Chef::Recipe).to receive(:platform_family?).and_return('windows')
        node.normal['terraform']['checksum'] = sha256sum
        node.normal['terraform']['win_install_dir'] = 'C:\terraform'
      end.converge(described_recipe)
    end

    it 'installed terraform' do
      expect(win_run).to install_ark('terraform').with(
        version: terraform_version,
        checksum: sha256sum,
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
