# @summary
#   Define a dhcp-pool for IPv4 networks
#
# @param network
#   Base-IP-Address of the pool
#
# @param mask
#   Networkmask of that pool
#
# @param host_mask
#   Networkmask that is supplied to the client
#   Defaults to `mask`. Use it to supply a smaller
#   mask to clients if needed
#
# @param gateway
#   Optional IP-address for the gateway
#
# @param range
#   Optional IP-range to supply addresses from
#   Specify as String with start- and end-IP-address
#   separated by space
#
# @param failover
#   Optional name of the DHCP-server to failover
#
# @param options
#   Optional String or Array of `option` to set in the pool
#
# @param parameters
#   Optional String or Array of manual parameters to set
#
# @param sharednetwork
#   Optional String to group this pool into a shared-network
#   segment by the name `sharednetwork`. You need to define
#   that segment by using `dhcp::sharednetwork`
#
# @param nameservers
#   Optional set of IPv4-nameservers to supply to the client
#
# @param nameservers_ipv6
#   Optional set of IPv6-nameservers to supply to the client
#
# @param pxeserver
#   Optional name of a PXE-server to boot from
#
# @param mtu
#   Optional size of the MTU to supply to the client
#
# @param domain_name
#   Optional domainname for the client
#
# @param ignore_unknown
#   Set to true to disable leases for clients not
#   explicitly defined by `dhcp::host`
#
# @param on_commit
#   Set of statements to execute when providing a lease
#
# @param on_release
#   Set of statements to execute when a lease is released
#
# @param on_expiry
#   Set of statements to execute when a lease expires
#
define dhcp::pool (
  Stdlib::IP::Address::V4 $network,
  Stdlib::IP::Address::V4 $mask,
  Stdlib::IP::Address::V4 $host_mask        = $mask,
  Optional[String[1]] $gateway              = undef,
  Optional[Variant[Array[String[1],1],String[1]]] $range = undef,
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

  concat::fragment { "dhcp_pool_${name}":
    target  => "${dhcp_dir}/dhcpd.pools",
    content => template('dhcp/dhcpd.pool.erb'),
    order   => "10 ${sharednetwork}-10",
  }

  if $sharednetwork {
    Dhcp::Sharednetwork[$sharednetwork] -> Concat::Fragment["dhcp_pool_${name}"]
  }
}
