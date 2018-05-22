# frozen_string_literal: true

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

  def import_key
    import = inspec.backend.run_command('gpg --import /tmp/hashicorp.asc')
    import.exit_status.zero?
  end

  # verify the sha256sum file's signature
  # this method is called by `it { should be_valid }`
  # returns true or false if the gpg signature is valid
  def valid?
    checksums_file = "terraform_#{@version}_SHA256SUMS"
    sigfile_path = "/tmp/#{checksums_file}.sig"
    checksums_file_path = "/tmp/#{checksums_file}"

    if import_key
      gpg_verify = inspec.backend.run_command(
        "gpg --verify #{sigfile_path} #{checksums_file_path}"
      )
      return gpg_verify.exit_status.zero?
    end
    false
  end

  def to_s
    "Terraform #{@version} GPG Signatures"
  end
end
