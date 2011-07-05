class dhcp {
  include dhcp::params

  $dhcp_dir    = $dhcp::params::dhcp_dir
  $domain      = $dhcp::params::domain
  $nameservers = $dhcp::params::nameservers
  $ntpserver   = $dhcp::params::ntpserver
  $pxeserver   = $dhcp::params::pxeserver
  $filename    = $dhcp::params::filename
  $logfacility = $dhcp::params::logfacility
  $packagename = $dhcp::params::packagename
  $servicename = $dhcp::params::servicename

  package {
    "$packagename":
      ensure => installed,
      provider => $operatingsystem ? {
        default => undef,
        darwin  => macports
      }
  }

# firewall { "dhcp":
#   proto => "udp",
#   dport => "67",
#   jump => "ACCEPT",
# }

  file {
    "${dhcp_dir}/dhcpd.conf":
      owner   => root,
      group   => 0,
      mode    => 644,
      require => Package["$packagename"],
      content => template("dhcp/dhcpd.conf.erb");
  }

  include concat::setup
  concat { "${dhcp_dir}/dhcpd.pools": }
  concat { "${dhcp_dir}/dhcpd.hosts": }

  service {
    "$servicename":
      enable    => "true",
      ensure    => "running",
      hasstatus => true,
      subscribe => [Concat["${dhcp_dir}/dhcpd.pools"], Concat["${dhcp_dir}/dhcpd.hosts"], File["${dhcp_dir}/dhcpd.conf"]],
      require   => Package["$packagename"];
  }

}

