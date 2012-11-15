class dhcp::ddns (
  $enable         = true,
  $dhcp_conf_ddns = 'dhcp/dhcpd.conf.ddns.erb',   # default template
  $zonemaster     = $fqdn,
  $key            = '',
  $domains        = [ $domain ]
) {

  include dhcp::params

  $dhcp_dir    = $dhcp::params::dhcp_dir
  $packagename = $dhcp::params::packagename

  concat::fragment { 'dhcp-conf-ddns':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => template($dhcp_conf_ddns),
    order   => 10,
  }

}
