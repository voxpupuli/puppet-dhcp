# frozen_string_literal: true

require 'spec_helper'

describe 'dhcp::pool', type: :define do
  let :title do
    'test_pool'
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
      'gateway' => '1.1.1.1',
      'mask' => '255.255.255.0',
      'host_mask' => '255.255.255.128',
      'network' => '1.1.1.0',
      'range' => '1.1.1.100 1.1.1.110'
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
        "# #{title} #{params['network']} #{params['mask']}",
        '#################################',
        "subnet #{params['network']} netmask #{params['mask']} {",
        '  pool',
        '  {',
        "    range #{params['range']};",
        '  }',
        '',
        "  option subnet-mask #{params['host_mask']};",
        "  option routers #{params['gateway']};",
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
