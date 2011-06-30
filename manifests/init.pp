class dhcp {
  include dhcp::params

  $dhcp_dir    = $dhcp::params::dhcp_dir
  $domain      = $dhcp::params::domain
  $nameservers = $dhcp::params::nameservers
  $ntpserver   = $dhcp::params::ntpserver
  $pxeserver   = $dhcp::params::pxeserver
  $filename    = $dhcp::params::filename
  $logfacility = $dhcp::params::logfacility

  package {
    "isc-dhcp-server":
      ensure => installed;
  }

# firewall { "dhcp":
#   proto => "udp",
#   dport => "67",
#   jump => "ACCEPT",
# }

  file {
    "${dhcp_dir}/dhcpd.conf":
      owner   => root,
      group   => root,
      mode    => 644,
      require => Package["isc-dhcp-server"],
      content => template("dhcp/dhcpd.conf.erb");
  }

  include concat::setup
  concat { "${dhcp_dir}/dhcpd.pools": }
  concat { "${dhcp_dir}/dhcpd.hosts": }

  service {
    "isc-dhcp-server":
      enable    => "true",
      ensure    => "running",
      hasstatus => true,
      subscribe => [Concat["${dhcp_dir}/dhcpd.pools"], Concat["${dhcp_dir}/dhcpd.hosts"], File["${dhcp_dir}/dhcpd.conf"]],
      require   => Package["isc-dhcp-server"];
  }

}

