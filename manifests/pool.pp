# == Define: dhcp::pool
#
define dhcp::pool (
  Stdlib::IP::Address::V4 $network,
  Stdlib::IP::Address::V4 $mask,
  $gateway                                  = '',
  $range                                    = '',
  $failover                                 = '',
  $options                                  = '',
  $parameters                               = '',
  Optional[Array[String]] $nameservers      = undef,
  Optional[Array[String]] $nameservers_ipv6 = undef,
  Optional[String] $pxeserver               = undef,
  Optional[Integer] $mtu                    = undef,
  String $domain_name                       = '',
  $ignore_unknown                           = undef,
  Array[String[1]] $on_commit               = [],
  Array[String[1]] $on_release              = [],
  Array[String[1]] $on_expiry               = [],

) {
  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_pool_${name}":
    target  => "${dhcp_dir}/dhcpd.pools",
    content => template('dhcp/dhcpd.pool.erb'),
  }
}
