# frozen_string_literal: true

require 'spec_helper'
require 'shared_examples'

describe 'terraform::gpgme' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new do |_node|
      allow(Dir).to receive(:tmpdir).and_return('/tmp')
    end.converge(described_recipe)
  end

  it 'installed gnupg2 and haveged' do
    expect(chef_run).to install_gpg_install('gnupg2 and haveged')
  end

  it 'deployed hashicorp.asc' do
    expect(chef_run).to create_cookbook_file('hashicorp.asc')
      .with(mode: '0644', path: '/tmp/hashicorp.asc')
  end

  it 'hashicorp.asc resource notified gpg key import' do
    rsrc = chef_run.cookbook_file('hashicorp.asc')
    expect(rsrc).to notify('gpg_key[import HashiCorp key to root keychain]')
      .to(:import).immediately
  end

  it 'imported hashicorp gpg key' do
    expect(chef_run).to import_gpg_key('import HashiCorp key to root keychain')
      .with(user: 'root', key_file: '/tmp/hashicorp.asc',
            name_real: 'HashiCorp Security')
  end

  %w[terraform_0.11.7_SHA256SUMS terraform_0.11.7_SHA256SUMS.sig].each do |f|
    it "downloaded #{f}" do
      url = "https://releases.hashicorp.com/terraform/0.11.7/#{f}"
      expect(chef_run).to create_remote_file(f)
        .with(path: "/tmp/#{f}", mode: '0644', source: url)
    end
  end
end
