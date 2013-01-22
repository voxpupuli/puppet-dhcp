# ----------
# Remove and Disable the DHCP server
# ----------
class isc_dhcp::disable(
  $packagename = $isc_dhcp::params::packagename,
  $servicename = $isc_dhcp::params::servicename,
) inherits isc_dhcp::params {

  package { $packagename:
    ensure => absent,
  }

  service { $servicename:
    ensure    => stopped,
    enable    => false,
    hasstatus => true,
    require   => Package[$packagename],
  }
}

