require 'spec_helper'

describe 'dhcp::pool', type: :define do
  let :title do
    'test_pool'
  end
  let(:facts) do
    {
      concat_basedir: '/dne',
      operatingsystem: 'RedHat',
      osfamily: 'RedHat',
      os: { family: 'RedHat' }
    }
  end
  let :params do
    {
      'gateway' => '1.1.1.1',
      'mask'    => '255.255.255.0',
      'network' => '1.1.1.0',
      'range'   => ['1.1.1.100', '1.1.1.110']
    }
  end
  let :pre_condition do
    "class { 'dhcp': interface => 'eth0' }"
  end

  it { is_expected.to contain_concat__fragment("dhcp_pool_#{title}") }
end
