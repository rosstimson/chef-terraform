# frozen_string_literal: true

# These are helper methods that can be used in this cookbook
# the Terraform namespace
require 'tmpdir'
require 'mixlib/shellout'

module Terraform
  # Helpers belonging to the Terraform namespace
  module Helpers
    # Transform raw output of the checksum list into a Hash[filename, checksum].
    def raw_checksums_to_hash
      return {} unless File.exist?(checksums_file_path)
      raw_checksums = File.open(checksums_file_path, 'r').read
      Hash[
        raw_checksums.split("\n").map do |s|
          s.split.reverse
        end
      ]
    end

    def sigfile
      "#{checksums_file}.sig"
    end

    def checksums_file
      "terraform_#{node['terraform']['version']}_SHA256SUMS"
    end

    def sigfile_path
      File.join(Dir.tmpdir, sigfile)
    end

    def checksums_file_path
      File.join(Dir.tmpdir, checksums_file)
    end

    # verify the sha256sum file's signatures can be trusted
    # @return: Boolean
    def signatures_trustworthy?
      cmd = 'sudo -u root -i gpg2 --verify ' \
        "#{sigfile_path} #{checksums_file_path}"
      gpg_verify = Mixlib::ShellOut.new(cmd)
      gpg_verify.run_command
      gpg_verify.exitstatus.zero?
    end

    def terraform_zipfile
      node['terraform']['zipfile']
    end

    def terraform_url_base(version = node['terraform']['version'])
      URI.parse("#{node['terraform']['url_base']}/#{version}").to_s
    end

    # See https://coderanger.net/derived-attributes/
    # for why this is the way it is
    def terraform_url
      ::File.join(terraform_url_base, terraform_zipfile)
    end

    alias_method 'sig_verified?', 'signatures_trustworthy?'
  end
end

::Chef::Node.send(:include, Terraform::Helpers)
::Chef::Recipe.send(:include, Terraform::Helpers)
::Chef::Provider.send(:include, Terraform::Helpers)
::Chef::Resource.send(:include, Terraform::Helpers)
