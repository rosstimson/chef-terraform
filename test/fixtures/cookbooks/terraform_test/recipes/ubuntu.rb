# ensure that packages can be installed under ubuntu
execute 'apt-get -y update' do
  only_if { platform_family?('debian') }
  action :nothing
end.run_action(:run)
