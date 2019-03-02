# == Define: dhcp::host
#
define dhcp::host (
  Stdlib::IP::Address $ip,
  Dhcp::Mac $mac,
  String $ddns_hostname = $name,
  Hash $options     = {},
  String $comment   = '',
  Boolean $ignored  = false,
) {

  $host = $name

  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_host_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.host.erb'),
    order   => '10',
  }
}
