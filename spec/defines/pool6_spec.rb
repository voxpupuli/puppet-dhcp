require 'spec_helper'

describe 'dhcp::pool6', type: :define do
  let :title do
    'test_pool6'
  end
  let(:facts) do
    {
      concat_basedir: '/dne',
      os: {
        family: 'RedHat',
        release: { major: '8' }
      }
    }
  end
  let :default_params do
    {
      'network'  => '2001:db8::',
      'prefix'   => 64,
      'range'    => '2001:db8::100 2001:db8::110'
    }
  end

  context 'creates a pool definition' do
    let(:params) { default_params }

    it { is_expected.to contain_concat__fragment("dhcp_pool_#{title}") }
  end

  context 'when optional parameters defined' do
    let(:params) do
      default_params.merge(
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

    it 'creates a pool declaration with optional parameters' do
      content = catalogue.resource('concat::fragment', "dhcp_pool_#{title}").send(:parameters)[:content]
      expected_lines = [
        '#################################',
        "# #{title} #{params['network']}/#{params['prefix']}",
        '#################################',
        "subnet6 #{params['network']}/#{params['prefix']} {",
        '  pool6',
        '  {',
        "    range6 #{params['range']};",
        '',
        '  }',
        '',
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
        '}',
      ]
      expect(content.split("\n")).to match_array(expected_lines)
    end
  end
end
