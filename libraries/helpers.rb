# These are helper methods that can be used in this cookbook
# the Terraform namespace
module Terraform
  # Helpers belonging to the Terraform namespace
  module Helpers
    # Transform raw output of the checksum list into a Hash[filename, checksum].
    def raw_checksums_to_hash
      raw_checksums = fetch_checksums
      Hash[
        raw_checksums.split("\n").map do |s|
          s.split.reverse
        end
      ]
    end

    # Downloads the raw checksums from hashicorp
    # https://releases.hashicorp.com/terraform/#{version}/#{checksum_file}
    def fetch_checksums
      version = node['terraform']['version']
      base = URI.parse(node['terraform']['url_base'])
      path = "#{base.path}/#{version}/terraform_#{version}_SHA256SUMS"
      uri = URI.join(node['terraform']['url_base'], path)
      Chef::HTTP::Simple.new("#{uri.scheme}://#{uri.host}").get(uri.path.to_s)
    end

    def terraform_url
      "#{node['terraform']['url_base']}/#{node['terraform']['version']}/" \
        "#{node['terraform']['zipfile']}  % {version: node['version']} "
    end

    private :fetch_checksums
  end
end

::Chef::Node.send(:include, Terraform::Helpers)
::Chef::Recipe.send(:include, Terraform::Helpers)
::Chef::Provider.send(:include, Terraform::Helpers)
::Chef::Resource.send(:include, Terraform::Helpers)
