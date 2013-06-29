require 'spec_helper'
require 'puppetlabs_spec_helper/module_spec_helper'
describe 'dhcp', :type => :class do
  context 'on a RedHat OS' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '6',
        :concat_basedir         => '/dne',
      }
    end
    let(:default_params) do
      {
        'dnsdomain'           => ['sampledomain.com','1.1.1.in-addr.arpa'],
        'nameservers'         => ['1.1.1.1'],
        'ntpservers'          => ['time.sample.com'],
        'dhcp_conf_header'    => ['eth0'],
        'dhcp_conf_ddns'      => 'INTERNAL_TEMPLATE',
        'dhcp_conf_pxe'       => 'INTERNAL_TEMPLATE',
        'dhcp_conf_extra'     => 'INTERNAL_TEMPLATE',
        'dhcp_conf_fragments' => {},
        'interfaces'          => 'undef',
        'interface'           => 'NOTSET',
        'dnsupdatekey'        => 'undef',
        'pxeserver'           => 'undef',
        'pxefilename'         => 'undef',
        'logfacility'         => 'daemon',
        'default_lease_time'  => '3600',
        'max_lease_time'      => '86400',
        'failover'            => ''
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
      ['dhcp','dhcp::monitor'].each do |dhclasses|
        it {should contain_class(dhclasses)}
      end
      ['/dhcpd.pools','/dhcpd.hosts'].each do |concats|
        it {should contain_concat(concats)}
      end
      ['dhcp-conf-pxe','dhcp-conf-extra'].each do |frags|
        it {should contain_concat__fragment(frags)}
      end
      ['/dhcpd.conf','/dhcpd.pools'].each do |files|
        it {should contain_file (files)}
      end
    end
  end
end