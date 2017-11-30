require 'spec_helper'

describe 'dhcp::ignoredsubnet' do
  let :title do
    'test_subnet'
  end
  let(:facts) do
    {
      concat_basedir: '/dne',
      osfamily: 'RedHat',
      os: { family: 'RedHat' }
    }
  end
  let :default_params do
    {
      'network' => '10.1.2.0',
      'mask' => '255.255.255.0'
    }
  end
  let(:params) { default_params }

  it { is_expected.to contain_concat__fragment("dhcp_ignoredsubnet_#{title}") }

  it 'creates a subnet declaration' do
    content = catalogue.resource('concat::fragment', "dhcp_ignoredsubnet_#{title}").send(:parameters)[:content]
    expected_lines = [
      '#################################',
      '# test_subnet 10.1.2.0 255.255.255.0',
      '#################################',
      'subnet 10.1.2.0 netmask 255.255.255.0 {',
      '  not authoritative;',
      '}'
    ]
    expect(content.split("\n")).to match_array(expected_lines)
  end
end
