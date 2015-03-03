# == Class: dhcp::params
#
class dhcp::params {

  case $::osfamily {
    'debian': {
      if ( $::operatingsystem == 'ubuntu' ) {
        if (versioncmp($::operatingsystemrelease, '12.04') >= 0) {
          $dhcp_dir    = '/etc/dhcp'
        } else {
          $dhcp_dir    = '/etc/dhcp3'
        }
      } else {
        $dhcp_dir    = '/etc/dhcp'
      }
      $packagename      = 'isc-dhcp-server'
      $servicename      = 'isc-dhcp-server'
      $package_provider = undef
    }
    'darwin': {
      $dhcp_dir         = '/opt/local/etc/dhcp'
      $packagename      = 'dhcp'
      $servicename      = 'org.macports.dhcpd'
      $package_provider = 'macports'
    }
    'freebsd': {
      $dhcp_dir         = '/usr/local/etc'
      $packagename      = 'net/isc-dhcp42-server'
      $servicename      = 'isc-dhcpd'
      $package_provider = undef
    }
    'redhat': {
      $dhcp_dir         = '/etc/dhcp'
      $packagename      = 'dhcp'
      $servicename      = 'dhcpd'
      $package_provider = undef
    }
    default: {
      fail('dhcp is supported on the following OS\'s: Debian, Ubuntu, Darwin, FreeBSD, RedHat, Fedora, and CentOS.')
    }
  }
}
