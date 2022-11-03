# @summary Remove and Disable the DHCP server
class dhcp::disable (
  String[1] $packagename = $dhcp::params::packagename,
  String[1] $servicename = $dhcp::params::servicename,
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
