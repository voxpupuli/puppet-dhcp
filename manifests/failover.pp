class dhcp::failover (
  $role                = "primary",
  $address             = $fqdn,
  $peer_address,
  $port                = '519',
  $max_response_delay  = '30',
  $max_unacked_updates = '10',
  $mclt                = '300',
  $split               = '128',
  $load_balance        = '3',
  $omapi_key           = ''
) {

  concat::fragment { 'dhcp-conf-failover':
      target  => "${dhcp_dir}/dhcpd.conf",
      content => template("dhcp/dhcpd.conf-failover.erb"),
  }

}
