class dhcp::disable {
  include dhcp::params

  $dhcp_dir    = $dhcp::params::dhcp_dir
  $dnsdomain   = $dhcp::params::dnsdomain
  $nameservers = $dhcp::params::nameservers
  $ntpserver   = $dhcp::params::ntpserver
  $pxeserver   = $dhcp::params::pxeserver
  $filename    = $dhcp::params::filename
  $logfacility = $dhcp::params::logfacility

  package {
    "isc-dhcp-server":
      ensure => absent;
  }
  service {
    "isc-dhcp-server":
      enable    => false,
      ensure    => "stopped",
      hasstatus => true,
      require   => Package["isc-dhcp-server"];
  }

}

