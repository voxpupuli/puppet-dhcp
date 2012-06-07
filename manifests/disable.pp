# ----------
# Remove and Disable the DHCP server
# ----------
class dhcp::disable {
  include dhcp::params

  $packagename = $dhcp::params::packagename
  $servicename = $dhcp::params::servicename

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

