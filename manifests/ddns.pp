class isc_dhcp::ddns (
  $enable         = true,
  $dhcp_conf_ddns = "${module_name}/dhcpd.conf.ddns.erb",
  $zonemaster     = $fqdn,
  $key            = '',
  $domains        = [ $domain ],
  $dhcp_dir       = $isc_dhcp::params::dhcp_dir,
  $packagename    = $isc_dhcp::params::packagename,
) inherits isc_dhcp::params {

  concat::fragment { 'dhcp-conf-ddns':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => template($dhcp_conf_ddns),
    order   => 10,
  }
}
