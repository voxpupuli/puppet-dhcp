# ----------
# Debian specific configuration items.
# ----------
class isc_dhcp::debian(
  $packagename     = $isc_dhcp::params::packagename,
  $servicename     = $isc_dhcp::params::servicename,
  $dhcp_interfaces = $isc_dhcp::params::dhcp_interfaces,
) inherits isc_dhcp::params {

  case $operatingsystem {
    'debian','ubuntu': {
      file{ '/etc/default/isc-dhcp-server':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        before  => Package[$packagename],
        notify  => Service[$servicename],
        content => template("${module_name}/debian/default_isc-dhcp-server"),
      }
    }
  }
}
