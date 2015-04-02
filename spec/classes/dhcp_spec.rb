require 'spec_helper'
require 'puppetlabs_spec_helper/module_spec_helper'
describe 'dhcp', :type => :class do
  let(:default_params) do
    {
      'dnsdomain'           => ['sampledomain.com','1.1.1.in-addr.arpa'],
      'nameservers'         => ['1.1.1.1'],
      'dhcp_conf_header'    => 'INTERNAL_TEMPLATE',
      'dhcp_conf_ddns'      => 'INTERNAL_TEMPLATE',
      'dhcp_conf_pxe'       => 'INTERNAL_TEMPLATE',
      'dhcp_conf_extra'     => 'INTERNAL_TEMPLATE',
      'dhcp_conf_fragments' => {},
      'logfacility'         => 'daemon',
      'default_lease_time'  => '3600',
      'max_lease_time'      => '86400',
    }
  end

  context 'on a RedHat OS' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystem        => 'RedHat',
        :operatingsystemrelease => '6',
        :concat_basedir         => '/dne',
      }
    end
    let :params do
       default_params
    end
    context 'input validation' do
      ['dnsdomain','nameservers','ntpservers'].each do |arrays|
        context "when #{arrays} is not an array" do
          it 'should fail' do
            params.merge!({ arrays => 'BOGON'})
            expect { subject }.to raise_error(Puppet::Error, /"BOGON" is not an Array.  It looks to be a String/)
          end
        end
      end
    end
    context 'coverage tests' do
      let :params do
        default_params.merge({
          :interface => 'eth0',
        })
       end
      ['dhcp','dhcp::monitor'].each do |dhclasses|
        it {should contain_class(dhclasses)}
      end
      ['/etc/dhcp/dhcpd.pools','/etc/dhcp/dhcpd.hosts'].each do |concats|
        it {should contain_concat(concats)}
      end
      ['dhcp-conf-pxe','dhcp-conf-extra'].each do |frags|
        it {should contain_concat__fragment(frags)}
      end
      ['/etc/dhcp/dhcpd.conf','/etc/dhcp/dhcpd.pools'].each do |files|
        it {should contain_file(files)}
      end
    end

    context 'header' do
      let :params do
        default_params.merge({
          :interfaces => ['eth0'],
        })
      end

      it 'defines dhcp header contents' do
        verify_concat_fragment_exact_contents(subject, 'dhcp-conf-header', [
          'authoritative;',
          'default-lease-time 3600;',
          'max-lease-time 86400;',
          'log-facility daemon;',
          'option domain-name "sampledomain.com";',
          'option domain-name-servers 1.1.1.1;',
          'option fqdn.no-client-update on;  # set the "O" and "S" flag bits',
          'option fqdn.rcode2 255;',
          'option pxegrub code 150 = text;',
        ])
      end

      context 'omapi_port => 7911' do
        let :params do
          default_params.merge({
            :interfaces => ['eth0'],
            :omapi_port => 7911,
          })
        end

        it 'defines dhcp header contents' do
          verify_concat_fragment_contents(subject, 'dhcp-conf-header', [
            'omapi-port 7911;',
          ])
        end
      end
    end

    context 'ntp' do
      let :params do
        default_params.merge({
          :interfaces => ['eth0'],
        })
      end

      it 'sets ntp-servers to none' do
        should contain_concat__fragment('dhcp-conf-ntp').with_content(/^option ntp-servers none;$/)
      end

      context 'ntpservers defined' do
        let :params do
          default_params.merge({
            :interfaces => ['eth0'],
            :ntpservers => ['time.sample.com'],
          })
        end

        it 'sets ntp-servers' do
          should contain_concat__fragment('dhcp-conf-ntp').with_content(/^option ntp-servers time.sample.com;$/)
        end
      end
    end

    context 'ddns' do
      let :params do
        default_params.merge({
          :interface => 'eth0',
        })
      end

      it do
        should contain_concat__fragment('dhcp-conf-ddns').with_content(/^ddns-update-style none;$/)
      end

      context 'dnsupdatekey defined' do
        let :params do
          default_params.merge({
            :interface => 'eth0',
            :dnsupdatekey => '/etc/rndc.key',
          })
        end

        it do
          content = subject.resource('concat::fragment', 'dhcp-conf-ddns').send(:parameters)[:content]
          expected_lines = [
            'ddns-updates on;',
            'ddns-update-style interim;',
            'update-static-leases on;',
            'use-host-decl-names on;',
            'include "/etc/rndc.key";',
            "zone #{params['dnsdomain'].first}. {",
            "  primary #{params['nameservers'].first};",
            '  key rndc.key;',
            '}',
            "zone #{params['dnsdomain'].last}. {",
            "  primary #{params['nameservers'].first};",
            '  key rndc.key;',
            '}',
          ]
          expect(content.split("\n").reject {|l| l =~ /^#|^$/ }).to eq(expected_lines)
        end

        context 'dnskeyname defined' do
          let :params do
            default_params.merge({
              :interface => 'eth0',
              :dnsupdatekey => '/etc/rndc.key',
              :dnskeyname => 'rndc-key',
            })
          end

          it do
            should contain_concat__fragment('dhcp-conf-ddns').with_content(/^  key rndc-key;$/)
          end
        end
      end
    end
  end
  context 'on a Dawin OS' do
    let :facts do
      {
        :osfamily               => 'Darwin',
        :concat_basedir         => '/dne',
      }
    end
    let :params do
      default_params.merge({
        :interface => 'eth0',
      })
    end
    it { should compile }
    it { should contain_package('dhcp') \
      .with_provider('macports')
    }
  end
  context 'on a Debian based OS' do
    let :default_facts do
      {
        :osfamily       => 'Debian',
        :concat_basedir => '/dne',
      }
    end
    context 'Debian' do
      let :facts do
        default_facts.merge({
          :operatingsystem => 'Debian',
        })
      end
      let :params do
        default_params.merge({
          :interface => 'eth0',
        })
      end
      it { should contain_package('isc-dhcp-server') }
      it { should contain_file('/etc/default/isc-dhcp-server') \
        .with_content(/INTERFACES=\"eth0\"/)
      }
    end
    context 'Ubuntu' do
      let :params do
        default_params.merge({
          :interface => 'eth0',
        })
      end
      context '12.04' do
        let :facts do
          default_facts.merge({
            :operatingsystem        => 'Ubuntu',
            :operatingsystemrelease => '12.04',
          })
        end
        it { should contain_file('/etc/dhcp/dhcpd.conf') }
      end
      context '10.04' do
        let :facts do
          default_facts.merge({
            :operatingsystem        => 'Ubuntu',
            :operatingsystemrelease => '10.04',
          })
        end
        it { should contain_file('/etc/dhcp3/dhcpd.conf') }
      end
    end
  end

  context 'with globaloptions parameter set' do
    let :facts do
      {
        :osfamily               => 'Debian',
        :operatingsystem        => 'Ubuntu',
        :operatingsystemrelease => '12.04',
        :concat_basedir         => '/dne',
      }
    end
    context 'globaloptions set to a string' do
      let :params do
        default_params.merge({
          :interface     => 'eth0',
          :globaloptions => 'root-path "/opt/ltsp/i386"',
        })
      end
      it { should contain_concat__fragment('dhcp-conf-header').with_content %r{^option root-path "/opt/ltsp/i386";$} }
    end

    context 'globaloptions set to an array' do
      let :params do
        default_params.merge({
          :interface     => 'eth0',
          :globaloptions => [ 'tftp-server-name "1.2.3.4"', 'root-path "/opt/ltsp/i386"', ]
        })
      end
      it { should contain_concat__fragment('dhcp-conf-header').with_content %r{^option root-path "/opt/ltsp/i386";$} }
      it { should contain_concat__fragment('dhcp-conf-header').with_content %r{^option tftp-server-name "1.2.3.4";$} }
    end
  end

end
