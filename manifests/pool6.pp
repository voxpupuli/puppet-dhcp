# @summary
#   Define a dhcp-pool for IPv6 networks
#
define dhcp::pool6 (
  Stdlib::IP::Address::V6 $network,
  Integer $prefix,
  Optional[Variant[Array[String[1],1],String[1]]] $range = undef,
  Optional[String[1]] $range_temp           = undef,
  Optional[String[1]] $failover             = undef,
  Optional[Variant[Array[String[1]],String[1]]] $options          = undef,
  Optional[Variant[Array[String[1]],String[1]]] $parameters       = undef,
  Optional[String[1]] $sharednetwork        = undef,
  Optional[Array[String]] $nameservers      = undef,
  Optional[Array[String]] $nameservers_ipv6 = undef,
  Optional[String] $pxeserver               = undef,
  Optional[Integer] $mtu                    = undef,
  Optional[String[1]] $domain_name          = undef,
  $ignore_unknown                           = undef,
  Array[String[1]] $on_commit               = [],
  Array[String[1]] $on_release              = [],
  Array[String[1]] $on_expiry               = [],
) {
  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_pool6_${name}":
    target  => "${dhcp_dir}/dhcpd.pools",
    content => template('dhcp/dhcpd.pool6.erb'),
    order   => "10 ${sharednetwork}-10",
  }

  if $sharednetwork {
    Dhcp::Sharednetwork[$sharednetwork] -> Concat::Fragment["dhcp_pool6_${name}"]
  }
}
