require 'spec_helper'

describe 'dhcp::host', type: :define do
  let :title do
    'test_host'
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
      'ip'      => '1.2.3.4',
      'mac'     => '90:FB:A6:E4:08:9F',
      'comment' => 'test_comment'
    }
  end
  let(:params) { default_params }

  it { is_expected.to contain_concat__fragment("dhcp_host_#{title}") }

  it 'creates a host declaration' do
    content = catalogue.resource('concat::fragment', "dhcp_host_#{title}").send(:parameters)[:content]
    expected_lines = [
      "host #{title} {",
      '  # test_comment',
      "  hardware ethernet   #{params['mac']};",
      "  fixed-address       #{params['ip']};",
      "  ddns-hostname       \"#{title}\";",
      '}'
    ]
    expect(content.split("\n")).to match_array(expected_lines)
  end

  context 'when options defined' do
    let(:params) do
      default_params.merge(
        options: {
          'vendor-encapsulated-options' => '01:04:31:41:50:43',
          'domain-name-servers'         => '10.0.0.1'
        }
      )
    end

    it 'creates a host declaration with options' do
      content = catalogue.resource('concat::fragment', "dhcp_host_#{title}").send(:parameters)[:content]
      expected_lines = [
        "host #{title} {",
        '  # test_comment',
        "  hardware ethernet   #{params['mac']};",
        "  fixed-address       #{params['ip']};",
        "  ddns-hostname       \"#{title}\";",
        '  option domain-name-servers 10.0.0.1;',
        '  option vendor-encapsulated-options 01:04:31:41:50:43;',
        '}'
      ]
      expect(content.split("\n")).to match_array(expected_lines)
    end
  end

  context 'when optional parameters defined' do
    let(:params) do
      default_params.merge(
        'default_lease_time' => 600,
        'max_lease_time'     => 900,
        'on_commit' => [
          'set ClientIP = binary-to-ascii(10, 8, ".", leased-address)',
          'execute("/usr/local/bin/my_dhcp_helper.sh", ClientIP)'
        ],
        'on_release' => [
          'set ClientIP = binary-to-ascii(10, 8, ".", leased-address)',
          'log(concat("Released IP: ", ClientIP))'
        ],
        'on_expiry' => [
          'set ClientIP = binary-to-ascii(10, 8, ".", leased-address)',
          'log(concat("Expired IP: ", ClientIP))'
        ]
      )
    end

    it 'creates a host declaration with optional parameters' do
      content = catalogue.resource('concat::fragment', "dhcp_host_#{title}").send(:parameters)[:content]
      expected_lines = [
        "host #{title} {",
        '  # test_comment',
        "  hardware ethernet   #{params['mac']};",
        "  fixed-address       #{params['ip']};",
        "  ddns-hostname       \"#{title}\";",
        '  default-lease-time  600;',
        '  max-lease-time      900;',
        '  on commit {',
        '    set ClientIP = binary-to-ascii(10, 8, ".", leased-address);',
        '    execute("/usr/local/bin/my_dhcp_helper.sh", ClientIP);',
        '  }',
        '  on release {',
        '    set ClientIP = binary-to-ascii(10, 8, ".", leased-address);',
        '    log(concat("Released IP: ", ClientIP));',
        '  }',
        '  on expiry {',
        '    set ClientIP = binary-to-ascii(10, 8, ".", leased-address);',
        '    log(concat("Expired IP: ", ClientIP));',
        '  }',
        '}'
      ]
      expect(content.split("\n")).to match_array(expected_lines)
    end
  end

  context 'when ignored defined' do
    let(:params) do
      default_params.merge(
        'ignored' => true
      )
    end

    it 'creates a host declaration with ignore booting' do
      content = catalogue.resource('concat::fragment', "dhcp_host_#{title}").send(:parameters)[:content]
      expected_lines = [
        "host #{title} {",
        '  # test_comment',
        "  hardware ethernet   #{params['mac']};",
        "  fixed-address       #{params['ip']};",
        "  ddns-hostname       \"#{title}\";",
        '  ignore              booting;',
        '}'
      ]
      expect(content.split("\n")).to match_array(expected_lines)
    end
  end
end
