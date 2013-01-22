# ----------
# Host Reservation
# ----------
define isc_dhcp::host (
  $dhcp_dir = $isc_dhcp::dhcp_dir
  $comment  = '',
  $ip,
  $mac,
) {

  unless defined(Class['isc_dhcp']) {
    fail('Must declare the class isc_dhcp before defining an isc_dhcp::host')
  }
  $host = $name

  concat::fragment { "dhcp_host_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template("${module_name}/dhcpd.host.erb"),
    order   => 10,
  }
}

