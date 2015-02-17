class dhcp::params {

  case $::operatingsystem {
    'debian': {
      $dhcp_dir    = '/etc/dhcp'
      $packagename = 'isc-dhcp-server'
      $packageprov = undef
      $servicename = 'isc-dhcp-server'
    }
    'ubuntu': {
      if versioncmp($::operatingsystemrelease, '12.04') >= 0 {
        $dhcp_dir    = '/etc/dhcp'
      } else {
        $dhcp_dir    = '/etc/dhcp3'
      }
      $packagename = 'isc-dhcp-server'
      $packageprov = undef
      $servicename = 'isc-dhcp-server'
    }
    'darwin': {
      $dhcp_dir    = '/opt/local/etc/dhcp'
      $packagename = 'dhcp'
      $packageprov = 'macports'
      $servicename = 'org.macports.dhcpd'
    }
    'freebsd': {
      $dhcp_dir    = '/usr/local/etc'
      $packagename = 'net/isc-dhcp42-server'
      $packageprov = undef
      $servicename = 'isc-dhcpd'
    }
    'redhat','fedora','centos': {
      $dhcp_dir    = '/etc/dhcp'
      $packagename = 'dhcp'
      $packageprov = undef
      $servicename = 'dhcpd'
    }
    default: {
      fail("${::operatingsystem} not supported in ${::module_name}")
    }
  }

}
