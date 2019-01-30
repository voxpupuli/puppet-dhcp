# == Define: dhcp::pool
#
define dhcp::pool (
  Stdlib::Compat::Ipv4 $network,
  Stdlib::Compat::Ipv4 $mask,
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
) {

  include dhcp
  $dhcp_dir = $dhcp::dhcp_dir

  concat::fragment { "dhcp_pool_${name}":
    target  => "${dhcp_dir}/dhcpd.pools",
    content => template('dhcp/dhcpd.pool.erb'),
  }
}
