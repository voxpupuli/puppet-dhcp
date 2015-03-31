require 'spec_helper'

describe 'dhcp::host', :type => :define do
  let :title do
    'test_host'
  end
  let(:facts) do
    {
      :concat_basedir => '/dne',
      :osfamily       => 'RedHat',
    }
  end
  let :default_params do
    {
      'ip'      => '1.2.3.4',
      'mac'     => '90:FB:A6:E4:08:9F',
      'comment' => 'test_comment'
    }
  end
  let(:params) { default_params }

  it { should contain_concat__fragment("dhcp_host_#{title}") }

  it 'creates a host declaration' do
    content = subject.resource('concat::fragment', "dhcp_host_#{title}").send(:parameters)[:content]
    expected_lines = [
      "host #{title} {",
      "  hardware ethernet   #{params['mac']};",
      "  fixed-address       #{params['ip']};",
      "  ddns-hostname       \"#{title}\";",
      '}',
    ]
    expect(content.split("\n")).to eq(expected_lines)
  end

  context 'when options defined' do
    let(:params) do
      default_params.merge({
        :options => {
          'vendor-encapsulated-options' => '01:04:31:41:50:43',
          'domain-name-servers'         => '10.0.0.1',
        }
      })
    end

    it 'creates a host declaration with options' do
      content = subject.resource('concat::fragment', "dhcp_host_#{title}").send(:parameters)[:content]
      expected_lines = [
        "host #{title} {",
        "  hardware ethernet   #{params['mac']};",
        "  fixed-address       #{params['ip']};",
        "  ddns-hostname       \"#{title}\";",
        "  option domain-name-servers 10.0.0.1;",
        "  option vendor-encapsulated-options 01:04:31:41:50:43;",
        '}',
      ]
      expect(content.split("\n")).to eq(expected_lines)
    end
  end
end
