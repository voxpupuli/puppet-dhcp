# ----------
# Failover Configuration
# ----------
class isc_dhcp::failover (
  $role                = 'primary',
  $address             = $ipaddress,
  $peer_address,
  $port                = '519',
  $max_response_delay  = '30',
  $max_unacked_updates = '10',
  $mclt                = '300',
  $load_split          = '128',
  $load_balance        = '3',
  $omapi_key           = '',
  $dhcp_dir            = $isc_dhcp::params::dhcp_dir,
) inhertis isc_dhcp::params {

  concat::fragment { 'dhcp-conf-failover':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => template("${module_name}/dhcpd.conf.failover.erb"),
  }
}
