# == Define: dhcp::host
#
define dhcp::host (
  $ip,
  $mac,
  $options = {},
  $comment=''
) {

  validate_hash($options)

  $host = $name

  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_host_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.host.erb'),
    order   => '10',
  }
}
