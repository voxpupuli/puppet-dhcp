class dhcp(
  $domain,
  $nameservers,
  $ntpservers,
  $dnsupdatekey = undef,
  $pxeserver = undef,
  $pxefilename = undef,
  $logfacility = 'local7'
) {

  include dhcp::params

  $dhcp_dir    = $dhcp::params::dhcp_dir
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
  concat::fragment { 'dhcp-hosts-header':
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => "# static DHCP hosts\n",
    order   => 01,
  }

  service {
    "$servicename":
      enable    => "true",
      ensure    => "running",
      hasstatus => true,
      #     subscribe => [Concat["${dhcp_dir}/dhcpd.pools"], Concat["${dhcp_dir}/dhcpd.hosts"], File["${dhcp_dir}/dhcpd.conf"]],
      require   => Package["$packagename"];
  }

}

