# == Define: dhcp::host
#
define dhcp::host (
  $ip,
  $mac,
  $options = {},
  $comment = '',
  $host    = $name,
) {
  if ! defined(Class['dhcp']) {
    fail('You must include the dhcp base class before using any dhcp defined resources')
  }

  validate_hash($options)

  concat::fragment { "dhcp_host_${name}":
    target  => "${::dhcp::dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.host.erb'),
    order   => '10',
  }
}
