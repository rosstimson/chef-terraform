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
      require 'uri'
      uri = URI.parse(node['terraform']['url_base'])
      terraform_releases = "#{uri.scheme}://#{uri.host}/"
      version = node['terraform']['version']
      checksum_file = "terraform_#{version}_SHA256SUMS"
      path = "#{uri.path}/#{version}/#{checksum_file}"
      Chef::HTTP::Simple.new(terraform_releases).get(path)
    end

    def terraform_url
      "#{node['terraform']['url_base']}/#{node['terraform']['version']}/" \
        "#{node['terraform']['zipfile']}"
    end

    private :fetch_checksums
  end
end

::Chef::Node.send(:include, Terraform::Helpers)
::Chef::Recipe.send(:include, Terraform::Helpers)
::Chef::Provider.send(:include, Terraform::Helpers)
::Chef::Resource.send(:include, Terraform::Helpers)
