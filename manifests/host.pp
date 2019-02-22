# == Define: dhcp::host
#
define dhcp::host (
  Stdlib::IP::Address $ip,
  Dhcp::Mac $mac,
  String $ddns_hostname                 = $name,
  Hash $options                         = {},
  String $comment                       = '',
  Boolean $ignored                      = false,
  Optional[Integer] $default_lease_time = undef,
  Optional[Integer] $max_lease_time     = undef,
  Array[String[1]] $on_commit           = [],
  Array[String[1]] $on_release          = [],
  Array[String[1]] $on_expiry           = [],
) {

  $host = $name

  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_host_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.host.erb'),
    order   => '10',
  }
}
