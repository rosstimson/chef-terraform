# frozen_string_literal: true

gpg = 'sudo -u root -i gpg2'

# Custom resource based on the InSpec resource DSL
class GpgSignature < Inspec.resource(1)
  require 'digest'

  name 'gpg_signature'
  desc 'check gpg signatures'
  example "
    describe gpg_signature('0.11.7') do
      it { should be_valid }
    end
  "

  def initialize(terraform_version)
    @version = terraform_version
  end

  # verify the sha256sum file's signature
  # this method is called by `it { should be_valid }`
  # returns true or false if the gpg signature is valid
  def valid?
    checksums_file = "terraform_#{@version}_SHA256SUMS"
    sigfile_path = "/tmp/#{checksums_file}.sig"
    checksums_file_path = "/tmp/#{checksums_file}"

    gpg_verify = inspec.backend.run_command(
      "sudo -u root -i gpg2 --verify #{sigfile_path} #{checksums_file_path}"
    )
    gpg_verify.exit_status.zero?
  end

  def to_s
    "Terraform #{@version} GPG Signatures"
  end
end
