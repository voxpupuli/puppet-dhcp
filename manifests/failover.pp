# @summary Manage a DHCP failover config
#
class dhcp::failover (
  $peer_address,
  $role                 = 'primary',
  $address              = $facts['networking']['ip'],
  $port                 = '519',
  $max_response_delay   = '30',
  $max_unacked_updates  = '10',
  $mclt                 = '300',
  $load_split           = '128',
  $load_balance         = '3',
  Optional[String[1]] $omapi_key = undef,
  $dhcp_dir             = $dhcp::dhcp_dir,
  $dhcpd_conf_filename  = $dhcp::dhcpd_conf_filename,
) {
  concat::fragment { 'dhcp-conf-failover':
    target  => "${dhcp_dir}/${dhcpd_conf_filename}",
    content => template('dhcp/dhcpd.conf.failover.erb'),
  }
}
