require 'spec_helper'

describe 'dhcp::host', :type => :define do
  let :title do
    'test_host'
  end
  let :params do {
    'ip'      => '1.2.3.4',
    'mac'     => '90:FB:A6:E4:08:9F',
    'comment' => 'test_comment'
  }
  end
  it {
    should contain_concat__fragment("dhcp_host_#{title}")
  }end