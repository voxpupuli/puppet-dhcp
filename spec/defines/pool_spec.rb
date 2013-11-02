require 'spec_helper'

describe 'dhcp::pool', :type => :define do
  let :title do
    'test_pool'
  end
  let(:facts) {{ :concat_basedir => '/dne' }}
  let :params do
    {
      'gateway'  => '1.1.1.1',
      'mask'     => '255.255.255.0',
      'network'  => '1.1.1.0',
      'range'    => ['1.1.1.100','1.1.1.110']
    }
  end

  it {
    should contain_concat__fragment("dhcp_pool_#{title}")
  }
end
