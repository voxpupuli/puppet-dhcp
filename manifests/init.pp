class dhcp (
    $dnsdomain,
    $nameservers,
    $ntpservers,
    $interfaces         = undef,
    $interface          = "NOTSET",
    $dnsupdatekey       = undef,
    $pxeserver          = undef,
    $pxefilename        = undef,
    $logfacility        = 'local7',
    $default_lease_time = 3600,
    $max_lease_time     = 86400,
    $failover           = ''
) {

  include dhcp::params

  $dhcp_dir    = $dhcp::params::dhcp_dir
  $packagename = $dhcp::params::packagename
  $servicename = $dhcp::params::servicename

  # Incase people set interface instead of interfaces work around
  # that. If they set both, use interfaces and the user is a unwise
  # and deserves what they get.
  if $interface != "NOTSET" and $interfaces == undef {
    $dhcp_interfaces = [ $interface ]
  } elsif $interface == "NOTSET" and $interfaces == undef {
    fail ("You need to set \$interfaces in $module_name")
  } else {
    $dhcp_interfaces = $interfaces
  }

  package { $packagename:
    ensure   => installed,
    provider => $operatingsystem ? {
      default => undef,
      darwin  => macports
    }
  }

  # Only debian and ubuntu have this style of defaults for startup.
  case $operatingsystem {
    'debian','ubuntu': {
      file{ '/etc/default/isc-dhcp-server':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        before  => Package[$packagename],
        notify  => Service[$servicename],
        content => template('dhcp/debian/default_isc-dhcp-server'),
      }
    }
  }

  include concat::setup
  Concat { require => Package[$packagename] }

  # dhcpd.conf
  concat {  "${dhcp_dir}/dhcpd.conf": }
  concat::fragment { 'dhcp-conf-header':
      target  => "${dhcp_dir}/dhcpd.conf",
      content => template("dhcp/dhcpd.conf-header.erb"),
      order   => 01,
  }
  concat::fragment { 'dhcp-conf-ddns':
      target  => "${dhcp_dir}/dhcpd.conf",
      content => template("dhcp/dhcpd.conf.ddns.erb"),
  }
  concat::fragment { 'dhcp-conf-pxe':
      target  => "${dhcp_dir}/dhcpd.conf",
      content => template("dhcp/dhcpd.conf.pxe.erb"),
  }
  concat::fragment { 'dhcp-conf-extra':
      target  => "${dhcp_dir}/dhcpd.conf",
      content => template("dhcp/dhcpd.conf-extra.erb"),
      order   => 99,
  }


  # dhcpd.pool
  concat { "${dhcp_dir}/dhcpd.pools": }
  concat::fragment { 'dhcp-pools-header':
    target  => "${dhcp_dir}/dhcpd.pools",
    content => "# DHCP Pools\n",
    order   => 01,
  }

  # dhcpd.hosts
  concat { "${dhcp_dir}/dhcpd.hosts": }
  concat::fragment { 'dhcp-hosts-header':
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => "# static DHCP hosts\n",
    order   => 01,
  }

  service { $servicename:
    enable    => "true",
    ensure    => "running",
    hasstatus => true,
    subscribe => [Concat["${dhcp_dir}/dhcpd.pools"], Concat["${dhcp_dir}/dhcpd.hosts"], File["${dhcp_dir}/dhcpd.conf"]],
    require   => Package[$packagename];
  }

  include dhcp::monitor

}

