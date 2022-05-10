require 'spec_helper'

describe 'dhcp::sharednetwork', type: :define do
  let :title do
    'test_sharednetwork'
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
      'sharednetwork' => 'shared1'
    }
  end

  context 'creates a shared-network definition' do
    let(:params) { default_params }

    it { is_expected.to contain_concat__fragment("dhcp_sharednetwork_#{title}_head") }
    it { is_expected.to contain_concat__fragment("dhcp_sharednetwork_#{title}_foot") }
  end

  context 'when optional parameters defined' do
    let(:params) do
      default_params.merge(
        'parameters' => [
          'ddns-updates off',
          'option routers 1.1.1.1'
        ]
      )
    end

    it 'creates a shared-network declaration with optional parameters' do
      content = catalogue.resource('concat::fragment', "dhcp_sharednetwork_#{title}_head").send(:parameters)[:content]
      expected_lines = [
        '#################################',
        "# Shared-Network #{title}",
        '#################################',
        "shared-network #{title} {",
        '  ddns-updates off;',
        '  option routers 1.1.1.1;',
      ]
      expect(content.split("\n")).to match_array(expected_lines)
    end
  end
end
