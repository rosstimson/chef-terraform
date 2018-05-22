# frozen_string_literal: true

# Custom resource based on the InSpec resource DSL
class GpgKey < Inspec.resource(1)
  name 'gpg_key'
  desc 'check named gpg key has been imported'
  example "
    describe gpg_key('security@hashicorp.com') do
      it { should be_imported }
    end
  "

  def initialize(key_or_name)
    @key_or_name = key_or_name
  end

  def imported?
    keys = inspec.backend.run_command("gpg --list-keys \"#{@key_or_name}\"")
    keys = keys.stdout.split("\n")
    !keys.empty? && keys.any? { |h| h.match?(/HashiCorp/) }
  end

  def to_s
    "GPG Key Imported: #{@key_or_name}"
  end
end
