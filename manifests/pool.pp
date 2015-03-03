# == Define: dhcp::pool
#
define dhcp::pool (
  $network,
  $mask,
  $gateway     = '',
  $range       = '',
  $failover    = '',
  $options     = '',
  $parameters  = '',
  $nameservers = undef,
  $pxeserver   = undef,
  $domain_name = '',
) {

  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_pool_${name}":
    target  => "${dhcp_dir}/dhcpd.pools",
    content => template('dhcp/dhcpd.pool.erb'),
  }
}
