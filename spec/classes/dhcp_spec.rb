require 'spec_helper'
describe 'dhcp', type: :class do
  let(:default_params) do
    {
      'dnsdomain'           => ['sampledomain.com', '1.1.1.in-addr.arpa'],
      'nameservers'         => ['1.1.1.1'],
      'nameservers_ipv6'    => ['1:5ee:bad::c0de'],
      'dhcp_conf_header'    => 'INTERNAL_TEMPLATE',
      'dhcp_conf_ddns'      => 'INTERNAL_TEMPLATE',
      'dhcp_conf_pxe'       => 'INTERNAL_TEMPLATE',
      'dhcp_conf_extra'     => 'INTERNAL_TEMPLATE',
      'dhcp_conf_fragments' => {},
      'logfacility'         => 'daemon',
      'default_lease_time'  => '43200',
      'max_lease_time'      => '86400'
    }
  end

  context 'on a RedHat OS' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystem: 'RedHat',
        operatingsystemrelease: '6',
        concat_basedir: '/dne'
      }
    end
    let :params do
      default_params
    end
    context 'input validation' do
      %w(dnsdomain nameservers ntpservers).each do |arrays|
        context "when #{arrays} is not an array" do
          let :params do
            super().merge(
              arrays => 'BOGON'
            )
          end
          it { is_expected.not_to compile }
        end
      end
    end
    context 'coverage tests' do
      let :params do
        default_params.merge(interface: 'eth0')
      end
      ['dhcp'].each do |dhclasses|
        it { is_expected.to contain_class(dhclasses) }
      end
      ['/etc/dhcp/dhcpd.pools', '/etc/dhcp/dhcpd.hosts'].each do |concats|
        it { is_expected.to contain_concat(concats) }
      end
      ['dhcp-conf-pxe', 'dhcp-conf-extra'].each do |frags|
        it { is_expected.to contain_concat__fragment(frags) }
      end
      ['/etc/dhcp/dhcpd.conf', '/etc/dhcp/dhcpd.pools', '/etc/dhcp/dhcpd.ignoredsubnets'].each do |file|
        it { is_expected.to contain_concat(file) }
      end
      it { is_expected.to compile.with_all_deps }
    end

    context 'header' do
      let :params do
        default_params.merge(interfaces: ['eth0'])
      end

      it 'defines dhcp header contents' do
        is_expected.to contain_concat__fragment('dhcp-conf-header')
      end

      it 'contains authoritative statement' do
        is_expected.to contain_concat__fragment('dhcp-conf-header').with_content(%r{^authoritative})
      end

      context 'dnssearchdomains param populated' do
        let :params do
          default_params.merge(
            interfaces: ['eth0'],
            dnssearchdomains: ['example.com', 'example.org']
          )
        end

        it 'writes domain-search option into config file with dnssearchdomains param value' do
          is_expected.to contain_concat__fragment('dhcp-conf-header').with_content(%r{option domain-search "example.com", "example.org";})
        end
      end

      context 'omitting dnssearchdomains param should not include option in config' do
        let :params do
          default_params.merge(
            interfaces: ['eth0']
          )
        end

        it 'may not have domain-search option' do
          is_expected.to contain_concat__fragment('dhcp-conf-header').without_content(%r{option domain-search})
        end
      end

      context 'dnssearchdomains param not array' do
        let :params do
          default_params.merge(
            interfaces: ['eth0'],
            dnssearchdomains: 'string'
          )
        end

        it { is_expected.not_to compile }
      end

      context 'omapi_port => 7911' do
        let :params do
          default_params.merge(
            interfaces: ['eth0'],
            omapi_port: 7911
          )
        end

        it 'defines dhcp header contents' do
          is_expected.to contain_concat__fragment('dhcp-conf-header')
        end
      end

      context 'authoritative => false' do
        let :params do
          default_params.merge(
            interfaces: ['eth0'],
            authoritative: false
          )
        end

        it 'contains not authoritative statement' do
          is_expected.to contain_concat__fragment('dhcp-conf-header').with_content(%r{^not authoritative})
        end
      end
    end

    context 'ntp' do
      let :params do
        default_params.merge(interfaces: ['eth0'])
      end

      it 'sets ntp-servers to none' do
        is_expected.to contain_concat__fragment('dhcp-conf-ntp').with_content(%r{^option ntp-servers none;$})
      end

      context 'ntpservers defined' do
        let :params do
          default_params.merge(
            interfaces: ['eth0'],
            ntpservers: ['time.sample.com']
          )
        end

        it 'sets ntp-servers' do
          is_expected.to contain_concat__fragment('dhcp-conf-ntp').with_content(%r{^option ntp-servers time.sample.com;$})
        end
      end
    end

    context 'ddns' do
      let :params do
        default_params.merge(interface: 'eth0')
      end

      it do
        is_expected.to contain_concat__fragment('dhcp-conf-ddns').with_content(%r{^ddns-update-style none;$})
      end

      context 'dnsupdatekey defined' do
        let :params do
          default_params.merge(
            interface: 'eth0',
            dnsupdatekey: '/etc/rndc.key',
            ddns_update_style: 'standard',
            ddns_update_static: 'on',
            ddns_update_optimize: 'on'
          )
        end

        it do
          content = catalogue.resource('concat::fragment', 'dhcp-conf-ddns').send(:parameters)[:content]
          expected_lines = [
            'ddns-updates on;',
            'ddns-update-style standard;',
            'update-static-leases on;',
            'update-optimization on;',
            'use-host-decl-names on;',
            'include "/etc/rndc.key";',
            "zone #{params['dnsdomain'].first}. {",
            "  primary #{params['nameservers'].first};",
            "  primary6 #{params['nameservers_ipv6'].first};",
            '  key rndc.key;',
            '}',
            "zone #{params['dnsdomain'].last}. {",
            "  primary #{params['nameservers'].first};",
            "  primary6 #{params['nameservers_ipv6'].first};",
            '  key rndc.key;',
            '}'
          ]
          expect(content.split("\n").reject { |l| l =~ %r{^#|^$} }).to eq(expected_lines)
        end

        context 'dnskeyname defined' do
          let :params do
            default_params.merge(
              interface: 'eth0',
              dnsupdatekey: '/etc/rndc.key',
              dnskeyname: 'rndc-key'
            )
          end

          it do
            is_expected.to contain_concat__fragment('dhcp-conf-ddns').with_content(%r{^  key rndc-key;$})
          end
        end
      end
    end
    context 'ldap enabled with logfile' do
      let :params do
        default_params.merge(
          interface: 'eth0',
          use_ldap: true,
          ldap_password: 'passw0rd',
          ldap_debug_file: '/var/log/dhcp-ldap-startup.log'
        )
      end

      it do
        content = catalogue.resource('concat::fragment', 'dhcp-conf-ldap').send(:parameters)[:content]
        expected_lines = [
          'ldap-port 389;',
          'ldap-server "localhost";',
          'ldap-username "cn=root, dc=example, dc=com";',
          'ldap-password "passw0rd";',
          'ldap-base-dn "dc=example, dc=com";',
          'ldap-method dynamic;',
          'ldap-debug-file "/var/log/dhcp-ldap-startup.log";'
        ]
        expect(content.split("\n").reject { |l| l =~ %r{^#|^$} }).to eq(expected_lines)
      end
    end
    context 'ldap enabled without logfile' do
      let :params do
        default_params.merge(
          interface: 'eth0',
          use_ldap: true,
          ldap_password: 'passw0rd'
        )
      end

      it do
        content = catalogue.resource('concat::fragment', 'dhcp-conf-ldap').send(:parameters)[:content]
        expected_lines = [
          'ldap-port 389;',
          'ldap-server "localhost";',
          'ldap-username "cn=root, dc=example, dc=com";',
          'ldap-password "passw0rd";',
          'ldap-base-dn "dc=example, dc=com";',
          'ldap-method dynamic;'
        ]
        expect(content.split("\n").reject { |l| l =~ %r{^#|^$} }).to eq(expected_lines)
      end
    end

    context 'mtu defined' do
      let :params do
        default_params.merge(
          interface: 'eth0',
          mtu: 9000
        )
      end

      it do
        is_expected.to contain_concat__fragment('dhcp-conf-header').with_content(%r{^option interface-mtu 9000;$})
      end
    end
  end
  context 'on a Darwin OS' do
    let :facts do
      {
        osfamily: 'Darwin',
        concat_basedir: '/dne'
      }
    end
    let :params do
      default_params.merge(interface: 'eth0')
    end
    it { is_expected.to compile.with_all_deps }
    it do
      is_expected.to contain_package('dhcp'). \
        with_provider('macports')
    end
    ['/opt/local/etc/dhcp/dhcpd.hosts', '/opt/local/etc/dhcp/dhcpd.conf', '/opt/local/etc/dhcp/dhcpd.ignoredsubnets', '/opt/local/etc/dhcp/dhcpd.pools'].each do |file|
      it { is_expected.to contain_concat(file) }
    end
  end
  context 'on a Debian based OS' do
    let :default_facts do
      {
        osfamily: 'Debian',
        concat_basedir: '/dne'
      }
    end
    context 'Debian' do
      let :facts do
        default_facts.merge(operatingsystem: 'Debian')
      end
      let :params do
        default_params.merge(interface: 'eth0')
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_package('isc-dhcp-server') }
      it do
        is_expected.to contain_file('/etc/default/isc-dhcp-server'). \
          with_content(%r{INTERFACES=\"eth0\"})
      end
    end
    context 'Ubuntu' do
      let :params do
        default_params.merge(interface: 'eth0')
      end
      context '12.04' do
        let :facts do
          default_facts.merge(
            osfamily: 'Debian',
            operatingsystem: 'Ubuntu',
            operatingsystemrelease: '12.04'
          )
        end
        it { is_expected.to compile.with_all_deps }
        ['/etc/dhcp/dhcpd.hosts', '/etc/dhcp/dhcpd.conf', '/etc/dhcp/dhcpd.ignoredsubnets', '/etc/dhcp/dhcpd.pools'].each do |file|
          it { is_expected.to contain_concat(file) }
        end
      end
      context '10.04' do
        let :facts do
          default_facts.merge(
            osfamily: 'Debian',
            operatingsystem: 'Ubuntu',
            operatingsystemrelease: '10.04'
          )
        end
        it { is_expected.to compile.with_all_deps }
        ['/etc/dhcp3/dhcpd.hosts', '/etc/dhcp3/dhcpd.conf', '/etc/dhcp3/dhcpd.ignoredsubnets', '/etc/dhcp3/dhcpd.pools'].each do |file|
          it { is_expected.to contain_concat(file) }
        end
      end
    end
  end

  context 'with globaloptions parameter set' do
    let :facts do
      {
        osfamily: 'Debian',
        operatingsystem: 'Ubuntu',
        operatingsystemrelease: '12.04',
        concat_basedir: '/dne'
      }
    end
    context 'globaloptions set to a string' do
      let :params do
        default_params.merge(
          interface: 'eth0',
          globaloptions: 'root-path "/opt/ltsp/i386"'
        )
      end
      it { is_expected.to contain_concat__fragment('dhcp-conf-header').with_content %r{^option root-path "/opt/ltsp/i386";$} }
    end

    context 'globaloptions set to an array' do
      let :params do
        default_params.merge(
          interface: 'eth0',
          globaloptions: ['tftp-server-name "1.2.3.4"', 'root-path "/opt/ltsp/i386"']
        )
      end
      it { is_expected.to contain_concat__fragment('dhcp-conf-header').with_content %r{^option root-path "/opt/ltsp/i386";$} }
      it { is_expected.to contain_concat__fragment('dhcp-conf-header').with_content(%r{^option tftp-server-name "1\.2\.3\.4";$}) }
    end
  end

  context 'alternate conf filename' do
    let :facts do
      {
        osfamily: 'Debian',
        operatingsystem: 'Ubuntu',
        operatingsystemrelease: '14.04',
        concat_basedir: '/dne'
      }
    end
    let :params do
      default_params.merge(
        interface: 'eth0',
        dhcpd_conf_filename: 'dhcpd6.conf'
      )
    end
    it { is_expected.to contain_concat('/etc/dhcp/dhcpd6.conf') }
  end

  context 'pxeserver defined' do
    let :facts do
      {
        osfamily: 'Debian',
        operatingsystem: 'Ubuntu',
        operatingsystemrelease: '12.04',
        concat_basedir: '/dne'
      }
    end
    let :params do
      default_params.merge(
        pxeserver: '1.2.3.4',
        pxefilename: 'pxelinux.0',
        interface: 'eth0'
      )
    end

    it do
      content = catalogue.resource('concat::fragment', 'dhcp-conf-pxe').send(:parameters)[:content]
      expected_lines = ['filename "pxelinux.0";', 'next-server 1.2.3.4;']
      expect(content.split("\n").reject { |l| l =~ %r{^#|^$} }).to eq(expected_lines)
    end

    context 'ipxefilename defined' do
      let :params do
        default_params.merge(
          ipxe_filename: 'undionly-20140116.kpxe',
          ipxe_bootstrap: 'bootstrap.kpxe',
          interface: 'eth0'
        )
      end

      it do
        content = catalogue.resource('concat::fragment', 'dhcp-conf-pxe').send(:parameters)[:content]
        expected_lines = [
          'if exists user-class and option user-class = "iPXE" {',
          '      filename "bootstrap.kpxe";',
          '} else {',
          '      filename "undionly-20140116.kpxe";',
          '}'
        ]
        expect(content.split("\n").reject { |l| l =~ %r{^#|^$} }).to eq(expected_lines)
      end
    end
  end
end
