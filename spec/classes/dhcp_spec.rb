require 'spec_helper'
require 'puppetlabs_spec_helper/module_spec_helper'
describe 'dhcp', :type => :class do
  context 'on a RedHat OS' do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystem        => 'RedHat',
        :operatingsystemrelease => '6',
        :concat_basedir         => '/dne',
      }
    end
    context 'called with defaults and mandatory params' do
      let :params do
        {
          'dnsdomain'   => ['sampledomain.com','1.1.1.in-addr.arpa'],
          'nameservers' => ['1.1.1.1'],
          'ntpservers'  => ['time.sample.com'],
        }
      end
      it 'should fail to compile' do
        expect { should compile }.to raise_error()
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
    end
    context 'coverage tests' do
      let :params do
        {
          'dnsdomain'   => ['sampledomain.com','1.1.1.in-addr.arpa'],
          'nameservers' => ['1.1.1.1'],
          'ntpservers'  => ['time.sample.com'],
          'interface'   => 'eth0',
        }
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
  end
end
