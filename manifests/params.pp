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
      $manage_dhcp_dir  = true
      $packagename      = 'isc-dhcp-server'
      $servicename      = 'isc-dhcp-server'
      $package_provider = undef
      $dhcpd_binary     = undef
    }
    'Darwin': {
      $dhcp_dir         = '/opt/local/etc/dhcp'
      $manage_dhcp_dir  = true
      $packagename      = 'dhcp'
      $servicename      = 'org.macports.dhcpd'
      $package_provider = 'macports'
      $dhcpd_binary     = undef
    }
    'FreeBSD': {
      $dhcp_dir         = '/usr/local/etc'
      $manage_dhcp_dir  = true
      $packagename      = 'net/isc-dhcp44-server'
      $servicename      = 'isc-dhcpd'
      $package_provider = undef
      $dhcpd_binary     = undef
    }
    'RedHat': {
      $dhcp_dir         = '/etc/dhcp'
      $manage_dhcp_dir  = true
      $packagename      = 'dhcp'
      $servicename      = 'dhcpd'
      $package_provider = undef
      $dhcpd_binary     = '/usr/sbin/dhcpd'
    }
    'Archlinux': {
      $dhcp_dir         = '/etc'
      $manage_dhcp_dir  = true
      $packagename      = 'dhcp'
      # we currently do not manage the dhcpd6 config
      #$servicename     = ['dhcpd4.service', 'dhcpd6.service']
      $servicename      = ['dhcpd4.service']
      $package_provider = 'pacman'
      $dhcpd_binary     = '/usr/bin/dhcpd'
    }
    'Solaris': {
      if ( $facts['os']['name'] != 'SmartOS' ) {
        fail('Only SmartOS variant of Solaris is supported.')
      }
      $dhcp_dir         = '/opt/local/etc/dhcp'
      $manage_dhcp_dir  = true
      $packagename      = 'isc-dhcpd'
      $servicename      = 'isc-dhcpd'
      $package_provider = undef
      $dhcpd_binary     = undef
    }
    default: {
      fail('dhcp is supported on the following OS\'s: Debian, Ubuntu, Darwin, FreeBSD, RedHat, Fedora, and CentOS.')
    }
  }
}
