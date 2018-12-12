require 'spec_helper'

describe 'Dhcp::Mac' do
  it do
    is_expected.to allow_values(
      'a:a:a:a:a:a',
      '00:00:00:00:00:00',
      '11:11:11:11:11:11',
      '22:22:22:22:22:22',
      '33:33:33:33:33:33',
      '44:44:44:44:44:44',
      '55:55:55:55:55:55',
      '66:66:66:66:66:66',
      '77:77:77:77:77:77',
      '88:88:88:88:88:88',
      '99:99:99:99:99:99',
      'aa:aa:aa:aa:aa:aa',
      'bb:bb:bb:bb:bb:bb',
      'cc:cc:cc:cc:cc:cc',
      'dd:dd:dd:dd:dd:dd',
      'ee:ee:ee:ee:ee:ee',
      'ff:ff:ff:ff:ff:ff',
      'AA:AA:AA:AA:AA:AA',
      'BB:BB:BB:BB:BB:BB',
      'CC:CC:CC:CC:CC:CC',
      'DD:DD:DD:DD:DD:DD',
      'EE:EE:EE:EE:EE:EE',
      'FF:FF:FF:FF:FF:FF'
    )
  end

  describe 'invalid value handling' do
    [
      nil,
      'aa:aa:aa:aa:aa',
      'aaa:aa:aa:aa:aa:aa',
      'aa:aaa:aa:aa:aa:aa',
      'aa:aa:aaa:aa:aa:aa',
      'aa:aa:aa:aaa:aa:aa',
      'aa:aa:aa:aa:aaa:aa',
      'aa:aa:aa:aa:aa:aaa',
      'aa:aa:aa:aa:aa:aa:aa',
      'gg:gg:gg:gg:gg:gg'
    ].each do |value|
      it { is_expected.not_to allow_value(value) }
    end
  end
end
