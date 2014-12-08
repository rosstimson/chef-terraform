# Encoding: utf-8
require 'serverspec'

# include Serverspec::Helper::Exec
# include Serverspec::Helper::DetectOS
set :backend, :exec

RSpec.configure do |c|
  c.before :all do
    c.path = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin'
  end
end
