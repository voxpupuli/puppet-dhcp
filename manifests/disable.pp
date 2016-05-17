# ----------
# Remove and Disable the DHCP server
# ----------
class dhcp::disable (
  $packagename = $dhcp::params::packagename,
  $servicename = $dhcp::params::servicename,
) inherits dhcp::params {



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

