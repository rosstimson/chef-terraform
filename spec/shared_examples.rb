shared_examples 'include_ark' do
  it 'included ark recipe' do
    expect(chef_run).to include_recipe('ark')
  end
end

shared_examples 'install_ark_terraform' do
  it 'installed terraform' do
    props = {
      version: terraform_version,
      checksum: sha256sum,
      has_binaries: ['terraform'],
      append_env_path: false,
      strip_components: 0
    }

    if chef_run.node['platform_family'] == 'windows'
      props.merge!(
        win_install_dir: 'C:\terraform',
        owner: 'Administrator'
      )
    end

    expect(chef_run).to install_ark('terraform').with(props)
  end
end
