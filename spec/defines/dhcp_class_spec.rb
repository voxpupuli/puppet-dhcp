require 'spec_helper'

describe 'dhcp::dhcp_class', type: :define do
  let(:title) { 'test_class' }
  let(:header) { ['#################################', "# Custom class #{title}", '#################################'] }
  let(:facts) do
    {
      osfamily: 'RedHat',
      os: { family: 'RedHat' }
    }
  end

  context 'with parameters string' do
    let(:params) do
      { 'parameters' => 'match option vendor-class-identifier' }
    end

    it { is_expected.to contain_concat__fragment("dhcp_class_#{title}") }

    it 'creates a class declaration' do
      content = catalogue.resource('concat::fragment', "dhcp_class_#{title}").send(:parameters)[:content]
      expected_lines = header + [
        %(class "#{title}" \{),
        '  match option vendor-class-identifier;',
        '}'
      ]
      expect(content.split("\n")).to match_array(expected_lines)
    end
  end

  context 'with parameters array' do
    let(:params) do
      { 'parameters' => ['match option vendor-class-identifier', 'match option identifier-2'] }
    end

    it { is_expected.to contain_concat__fragment("dhcp_class_#{title}") }

    it 'creates a class declaration' do
      content = catalogue.resource('concat::fragment', "dhcp_class_#{title}").send(:parameters)[:content]
      expected_lines = header + [
        %(class "#{title}" \{),
        '  match option vendor-class-identifier;',
        '  match option identifier-2;',
        '}'
      ]
      expect(content.split("\n")).to match_array(expected_lines)
    end
  end
end
