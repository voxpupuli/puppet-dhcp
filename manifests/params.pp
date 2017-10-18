# == Class: dhcp::params
#
class dhcp::params {

  case $facts['os']['family'] {
    'Debian': {
      if ( $facts['os']['name'] == 'Ubuntu' ) {
        if (versioncmp($facts['os']['release']['full'], '12.04') >= 0) {
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
    'Darwin': {
      $dhcp_dir         = '/opt/local/etc/dhcp'
      $packagename      = 'dhcp'
      $servicename      = 'org.macports.dhcpd'
      $package_provider = 'macports'
    }
    'FreeBSD': {
      $dhcp_dir         = '/usr/local/etc'
      $packagename      = 'net/isc-dhcp43-server'
      $servicename      = 'isc-dhcpd'
      $package_provider = undef
    }
    'RedHat': {
      $dhcp_dir         = '/etc/dhcp'
      $packagename      = 'dhcp'
      $servicename      = 'dhcpd'
      $package_provider = undef
    }
    'Archlinux': {
      $dhcp_dir         = '/etc'
      $packagename      = 'dhcp'
      # we currently do not manage the dhcpd6 config
      #$servicename      = ['dhcpd4.service', 'dhcpd6.service']
      $servicename      = ['dhcpd4.service']
      $package_provider = 'pacman'
    }
    'Solaris': {
      if ( $facts['os']['name'] != 'SmartOS' ) {
        fail('Only SmartOS variant of Solaris is supported.')
      }
      $dhcp_dir         = '/opt/local/etc/dhcp'
      $packagename      = 'isc-dhcpd'
      $servicename      = 'isc-dhcpd'
      $package_provider = undef
    }
    default: {
      fail('dhcp is supported on the following OS\'s: Debian, Ubuntu, Darwin, FreeBSD, RedHat, Fedora, and CentOS.')
    }
  }
}
