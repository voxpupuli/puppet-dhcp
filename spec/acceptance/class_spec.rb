require 'spec_helper_acceptance'

describe 'dhcp class' do
  servicename = case fact('os.family')
                when 'Debian'
                  'isc-dhcp-server'
                when 'RedHat'
                  'dhcpd'
                end
  context 'minimal parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { 'dhcp':
        interface => $facts['networking']['primary'],
      }
      dhcp::pool{ 'ops.dc1.example.net':
        network => $facts['networking']['interfaces'][$facts['networking']['primary']]['network'],
        mask    => $facts['networking']['interfaces'][$facts['networking']['primary']]['netmask'],
        range   => ['172.17.0.3 172.17.0.5'],
        gateway => '172.17.0.1',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
    describe service(servicename) do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end
  context 'minimal other parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { 'dhcp':
        interfaces => [$facts['networking']['primary']],
      }
      dhcp::pool{ 'ops.dc1.example.net':
        network => $facts['networking']['interfaces'][$facts['networking']['primary']]['network'],
        mask    => $facts['networking']['interfaces'][$facts['networking']['primary']]['netmask'],
        range   => ['172.17.0.3 172.17.0.5'],
        gateway => '172.17.0.1',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
    describe service(servicename) do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end
end
