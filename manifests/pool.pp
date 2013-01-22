define isc_dhcp::pool (
  $network,
  $mask,
  $range,
  $gateway,
  $failover   = '',
  $options    = '',
  $parameters = '',
  $dhcp_dir   = $isc_dhcp::dhcp_dir,
) inherits isc_dhcp::params {

  unless defined(Class['isc_dhcp']) {
    fail('Must declare the class isc_dhcp before defining an isc_dhcp::pool')
  }

  concat::fragment { "dhcp_pool_${name}":
    target  => "${dhcp_dir}/dhcpd.pools",
    content => template("${module_name}/dhcpd.pool.erb"),
  }
}
