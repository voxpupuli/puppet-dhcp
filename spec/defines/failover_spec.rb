require 'spec_helper'

describe 'dhcp::pool', :type => :define do
  let :title do
    'test_pool'
  end
  let(:facts) do
    {
      :concat_basedir => '/dne',
      :osfamily => 'RedHat',
    }
  end

  let :default_params do
    {
      'gateway' => '1.1.1.1',
      'mask' => '255.255.255.0',
      'network' => '1.1.1.0',
      'range' => ['1.1.1.100', '1.1.1.110'],
    }
  end

  let :params do
    default_params
  end

  it { should contain_concat__fragment("dhcp_pool_#{title}") }
  it { should_not contain_concat__fragment('failover peer "dhcp-failover"') }

  context 'failover' do
    let :params do
      default_params.merge({
        :failover => 'failover',
      })
    end

    it { should contain_concat__fragment('failover peer "dhcp-failover"') }

  end

end
