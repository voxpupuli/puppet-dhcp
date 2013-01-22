# ----------
# DHCP Server Configuration
# ----------
class isc_dhcp (
  $dnsdomain,
  $nameservers,
  $ntpservers,
  $dhcp_conf_header    = "${module_name}/dhcpd.conf-header.erb",
  $dhcp_conf_pxe       = "${module_name}/dhcpd.conf.pxe.erb",
  $dhcp_conf_extra     = "${module_name}/dhcpd.conf-extra.erb",
  $dhcp_conf_fragments = {},
  $interfaces          = undef,
  $interface           = 'NOTSET',
  $pxeserver           = undef,
  $pxefilename         = undef,
  $logfacility         = 'daemon',
  $default_lease_time  = 3600,
  $max_lease_time      = 86400,
  $failover            = '',
  $ddns                = false,
  $dhcp_dir            = $isc_dhcp::params::dhcp_dir,
  $packagename         = $isc_dhcp::params::packagename,
  $servicename         = $isc_dhcp::params::servicename,
  $dhcpd               = $isc_dhcp::params::dhcpd,
) inherits isc_dhcp::params {

  # Incase people set interface instead of interfaces work around
  # that. If they set both, use interfaces and the user is a unwise
  # and deserves what they get.
  if $interface != 'NOTSET' and $interfaces == undef {
    $dhcp_interfaces = [ $interface ]
  } elsif $interface == 'NOTSET' and $interfaces == undef {
    fail ("You need to set \$interfaces in ${module_name}")
  } else {
    $dhcp_interfaces = $interfaces
  }

  package { $packagename:
    ensure => installed,
  }

  # OS Specifics
  case $operatingsystem {
    'debian','ubuntu': {
      include isc_dhcp::debian
    }
  }

  include concat::setup
  Concat { require => Package[$packagename] }

  #
  # Build up the dhcpd.conf
  concat {  "${dhcp_dir}/dhcpd.conf": }

  concat::fragment { 'dhcp-conf-header':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => template($dhcp_conf_header),
    order   => 01,
  }

  concat::fragment { 'dhcp-conf-pxe':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => template($dhcp_conf_pxe),
    order   => 20,
  }

  concat::fragment { 'dhcp-conf-extra':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => template($dhcp_conf_extra),
    order   => 99,
  }

  # Using DDNS will require a dhcp::ddns class composition, else, we should
  # turn it off.
  unless $ddns {
    class { "isc_dhcp::ddns": enable => false; }
  }

  # Any additional dhcpd.conf fragments the user passed in as a hash for
  # create_resources.  This allows the end user almost total control over the
  # DHCP server without modifying this module at all.

  # JJM This is commented out because the create_resources in PE does not
  # support the third option.
  # $fragment_defaults = {
  #   content => "# Managed by Puppet\n",
  #   target  => "${dhcp_dir}/dhcpd.conf",
  #   order   => 80,
  # }
  create_resources('concat::fragment', $dhcp_conf_fragments)

  #
  # Build the dhcpd.pools
  concat { "${dhcp_dir}/dhcpd.pools": }

  concat::fragment { 'dhcp-pools-header':
    target  => "${dhcp_dir}/dhcpd.pools",
    content => "# DHCP Pools\n",
    order   => 01,
  }

  #
  # Build the dhcpd.hosts
  concat { "${dhcp_dir}/dhcpd.hosts": }

  concat::fragment { 'dhcp-hosts-header':
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => "# static DHCP hosts\n",
    order   => 01,
  }

  service { $servicename:
    ensure    => running,
    enable    => true,
    hasstatus => true,
    subscribe => [Concat["${dhcp_dir}/dhcpd.pools"], Concat["${dhcp_dir}/dhcpd.hosts"], File["${dhcp_dir}/dhcpd.conf"]],
    require   => Package[$packagename],
    restart   => "${dhcpd} -t && service ${servicename} restart",
  }
}
