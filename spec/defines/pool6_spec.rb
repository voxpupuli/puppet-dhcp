require 'spec_helper'

describe 'dhcp::pool6', type: :define do
  let :title do
    'test_pool6'
  end
  let(:facts) do
    {
      concat_basedir: '/dne',
      osfamily: 'RedHat',
      os: { family: 'RedHat' }
    }
  end
  let :params do
    {
      'network'  => '2001:db8::',
      'prefix'   => 64,
      'range'    => '2001:db8::100 2001:db8::110'
    }
  end

  it { is_expected.to contain_concat__fragment("dhcp_pool_#{title}") }
end
