# == Class: dhcp
#
class dhcp (
  $dnsdomain           = undef,
  $nameservers         = [ '8.8.8.8', '8.8.4.4' ],
  $ntpservers          = [],
  $dhcp_conf_header    = 'INTERNAL_TEMPLATE',
  $dhcp_conf_ddns      = 'INTERNAL_TEMPLATE',
  $dhcp_conf_ntp       = 'INTERNAL_TEMPLATE',
  $dhcp_conf_pxe       = 'INTERNAL_TEMPLATE',
  $dhcp_conf_extra     = 'INTERNAL_TEMPLATE',
  $dhcp_conf_fragments = {},
  $interfaces          = undef,
  $interface           = 'NOTSET',
  $dnsupdatekey        = undef,
  $dnskeyname          = undef,
  $pxeserver           = undef,
  $pxefilename         = undef,
  $logfacility         = 'daemon',
  $default_lease_time  = 3600,
  $max_lease_time      = 86400,
  $service_ensure      = running,
  $globaloptions       = '',
  $omapi_port          = undef,
) {

  if $dnsdomain == undef {
    if $::domain {
      $dnsdomain_real = [ $::domain ]
    } else {
      fail('dhcp::dnsdomain must be set and domain fact is missing to use as a default value.')
    }
  } else {
    $dnsdomain_real = $dnsdomain
  }
  validate_array($dnsdomain_real)

  validate_array($nameservers)
  validate_array($ntpservers)

  include dhcp::params
  include dhcp::monitor

  $dhcp_dir         = $dhcp::params::dhcp_dir
  $packagename      = $dhcp::params::packagename
  $servicename      = $dhcp::params::servicename
  $package_provider = $dhcp::params::package_provider

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

  if $dnsupdatekey {
    $_dnsupdatekey_split    = split($dnsupdatekey, '[/]')
    $_dnsupdatekey_basename = $_dnsupdatekey_split[-1]
    $_dnskeyname            = pick($dnskeyname, $_dnsupdatekey_basename)
  } else {
    $_dnskeyname            = $dnskeyname
  }

  # JJM Decide where to pull the fragment content from.  Either this module, or
  # from the end user.  This makes the module much more re-usable by 3rd
  # parties without modifying the module itself.
  #
  # NOTE: These templates should be evaluated after all other local variables
  # have been set.
  $dhcp_conf_header_real = $dhcp_conf_header ? {
    'INTERNAL_TEMPLATE' => template('dhcp/dhcpd.conf-header.erb'),
    default             => $dhcp_conf_header,
  }
  $dhcp_conf_ntp_real = $dhcp_conf_ntp ? {
    'INTERNAL_TEMPLATE' => template('dhcp/dhcpd.conf.ntp.erb'),
    default             => $dhcp_conf_ntp,
  }
  $dhcp_conf_ddns_real = $dhcp_conf_ddns ? {
    'INTERNAL_TEMPLATE' => template('dhcp/dhcpd.conf.ddns.erb'),
    default             => $dhcp_conf_ddns,
  }
  $dhcp_conf_pxe_real = $dhcp_conf_pxe ? {
    'INTERNAL_TEMPLATE' => template('dhcp/dhcpd.conf.pxe.erb'),
    default             => $dhcp_conf_pxe,
  }
  $dhcp_conf_extra_real = $dhcp_conf_extra ? {
    'INTERNAL_TEMPLATE' => template('dhcp/dhcpd.conf-extra.erb'),
    default             => $dhcp_conf_extra,
  }

  package { $packagename:
    ensure   => installed,
    provider => $package_provider,
  }

  file { $dhcp_dir:
    mode    => '0755',
    require => Package[$packagename],
  }

  # Only debian and ubuntu have this style of defaults for startup.
  case $::osfamily {
    'debian': {
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
    'redhat': {
      file{ '/etc/sysconfig/dhcpd':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        before  => Package[$packagename],
        notify  => Service[$servicename],
        content => template('dhcp/redhat/sysconfig-dhcpd'),
      }
    }
    default: { }
  }

  Concat { require => Package[$packagename] }

  # dhcpd.conf
  concat {  "${dhcp_dir}/dhcpd.conf": }
  concat::fragment { 'dhcp-conf-header':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => $dhcp_conf_header_real,
    order   => '01',
  }
  concat::fragment { 'dhcp-conf-ntp':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => $dhcp_conf_ntp_real,
    order   => '02',
  }
  concat::fragment { 'dhcp-conf-ddns':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => $dhcp_conf_ddns_real,
    order   => '10',
  }
  concat::fragment { 'dhcp-conf-pxe':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => $dhcp_conf_pxe_real,
    order   => '20',
  }
  concat::fragment { 'dhcp-conf-extra':
    target  => "${dhcp_dir}/dhcpd.conf",
    content => $dhcp_conf_extra_real,
    order   => '99',
  }

  # Any additional dhcpd.conf fragments the user passed in as a hash for
  # create_resources.  This allows the end user almost total control over the
  # DHCP server without modifying this module at all.

  # JJM This is commented out because the create_resources in PE does not
  # support the third option.
  # $fragment_defaults = {
  #   content => "# Managed by Puppet\n",
  #   target  => "${dhcp_dir}/dhcpd.conf",
  #   order   => '80',
  # }
  create_resources('concat::fragment', $dhcp_conf_fragments)

  # dhcpd.pool
  concat { "${dhcp_dir}/dhcpd.pools": }
  concat::fragment { 'dhcp-pools-header':
    target  => "${dhcp_dir}/dhcpd.pools",
    content => "# DHCP Pools\n",
    order   => '01',
  }

  # dhcpd.ignoredsubnets
  concat { "${dhcp_dir}/dhcpd.ignoredsubnets": }
  concat::fragment { 'dhcp-ignoredsubnets-header':
    target  => "${dhcp_dir}/dhcpd.ignoredsubnets",
    content => "# DHCP Subnets (ignored)\n",
    order   => 01,
  }

  # dhcpd.hosts
  concat { "${dhcp_dir}/dhcpd.hosts": }
  concat::fragment { 'dhcp-hosts-header':
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => "# static DHCP hosts\n",
    order   => '01',
  }

  service { $servicename:
    ensure    => $service_ensure,
    enable    => true,
    hasstatus => true,
    subscribe => [Concat["${dhcp_dir}/dhcpd.pools"], Concat["${dhcp_dir}/dhcpd.hosts"], Concat["${dhcp_dir}/dhcpd.conf"]],
    require   => Package[$packagename],
  }
}
