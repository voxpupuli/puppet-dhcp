class dhcp::params {

  case $::osfamily {
    default: {
      fail("${::osfamily} not spupprted in ${module_name}")
    }
    debian: {
      if ( $::operatingsytem == 'ubuntu' ) {
        if versioncmp($::operatingsystemrelease, '12.04') >= 0 {
          $dhcp_dir    = '/etc/dhcp'
        } else {
          $dhcp_dir    = '/etc/dhcp3'
        }
      } else {
        $dhcp_dir    = '/etc/dhcp'
      }
      $packagename = 'isc-dhcp-server'
      $servicename = 'isc-dhcp-server'
    }
    darwin: {
      $dhcp_dir    = '/opt/local/etc/dhcp'
      $packagename = 'dhcp'
      $packageprov = 'macports'
      $servicename = 'org.macports.dhcpd'
    }
    freebsd: {
      $dhcp_dir    = '/usr/local/etc'
      $packagename = 'net/isc-dhcp42-server'
      $servicename = 'isc-dhcpd'
    }
    redhat: {
      $dhcp_dir    = '/etc/dhcp'
      $packagename = 'dhcp'
      $servicename = 'dhcpd'
    }
  }

}
