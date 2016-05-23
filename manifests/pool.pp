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
  $ignore_unknown = undef,
) {
  if ! defined(Class['dhcp']) {
    fail('You must include the dhcp base class before using any dhcp defined resources')
  }

  concat::fragment { "dhcp_pool_${name}":
    target  => "${::dhcp::dhcp_dir}/dhcpd.pools",
    content => template('dhcp/dhcpd.pool.erb'),
  }
}
