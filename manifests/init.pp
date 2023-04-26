# @summary Manage an ISC DHCP server
#
class dhcp (
  Optional[Array[String[1]]] $dnsdomain                            = undef,
  Array[Stdlib::IP::Address::V4] $nameservers                      = [],
  Array[Stdlib::IP::Address::V6] $nameservers_ipv6                 = [],
  Array[Variant[Stdlib::Fqdn,Stdlib::IP::Address]] $ntpservers     = [],
  Array[String[1]] $dnssearchdomains                               = [],
  String $dhcp_conf_header                                         = 'INTERNAL_TEMPLATE',
  String $dhcp_conf_ddns                                           = 'INTERNAL_TEMPLATE',
  String $dhcp_conf_ntp                                            = 'INTERNAL_TEMPLATE',
  String $dhcp_conf_pxe                                            = 'INTERNAL_TEMPLATE',
  String $dhcp_conf_extra                                          = 'INTERNAL_TEMPLATE',
  Hash[String[1], Hash[String[1], String[1]]] $dhcp_conf_fragments = {},
  Optional[Array[String[1]]] $interfaces                           = undef,
  String[1] $interface                                             = 'NOTSET',
  Optional[String[1]] $dnsupdatekey                                = undef,
  String[1] $ddns_update_style                                     = 'interim',
  Optional[String[1]] $dnskeyname                                  = undef,
  String[1] $ddns_update_static                                    = 'on',
  String[1] $ddns_update_optimize                                  = 'on',
  Enum['allow', 'deny'] $ddns_client_updates                       = 'allow',
  Optional[Stdlib::Host] $pxeserver                                = undef,
  Optional[String[1]] $pxefilename                                 = undef,
  Optional[Integer[1]] $mtu                                        = undef,
  Optional[String[1]] $ipxe_filename                               = undef,
  Optional[String[1]] $ipxe_bootstrap                              = undef,
  Dhcp::Syslogfacility $logfacility                                = 'daemon',
  Integer[-1] $default_lease_time                                  = 43200,
  Integer[-1] $max_lease_time                                      = 86400,
  Stdlib::Ensure::Service $service_ensure                          = 'running',
  Optional[Variant[String,Array[String[1]]]] $globaloptions        = undef,
  Optional[Stdlib::Port] $omapi_port                               = undef,
  Optional[String[1]] $omapi_name                                  = undef,
  String[1] $omapi_algorithm                                       = 'HMAC-MD5',
  Optional[String[1]] $omapi_key                                   = undef,
  Boolean $authoritative                                           = true,
  Variant[Array[String[1]],String[1]] $extra_config                = [],
  Stdlib::Absolutepath $dhcp_dir                                   = $dhcp::params::dhcp_dir,
  String[1] $dhcpd_conf_filename                                   = 'dhcpd.conf',
  String[1] $packagename                                           = $dhcp::params::packagename,
  Boolean $manage_package                                          = true,
  Variant[String[1],Array[String[1]]] $servicename                 = $dhcp::params::servicename,
  Boolean $manage_service                                          = true,
  Optional[String[1]] $package_provider                            = $dhcp::params::package_provider,
  Stdlib::Port $ldap_port                                          = 389,
  String[1] $ldap_server                                           = 'localhost',
  String[1] $ldap_username                                         = 'cn=root, dc=example, dc=com',
  Optional[String[1]] $ldap_password                               = undef,
  String[1] $ldap_base_dn                                          = 'dc=example, dc=com',
  Enum['dynamic', 'static'] $ldap_method                           = 'dynamic',
  Optional[Stdlib::Absolutepath] $ldap_debug_file                  = undef,
  Boolean $use_ldap                                                = false,
  String[1] $option_code150_label                                  = 'pxegrub',
  String[1] $option_code150_value                                  = 'text',
  Hash[String[1], Hash] $dhcp_classes                              = {},
  Hash[String[1], Hash] $hosts                                     = {},
  Hash[String, Hash] $ignoredsubnets                               = {},
  Hash[String, Hash] $pools                                        = {},
  Hash[String, Hash] $pools6                                       = {},
  Hash[String, Hash] $sharednetworks                               = {},
  Array[String[1]] $on_commit                                      = [],
  Array[String[1]] $on_release                                     = [],
  Array[String[1]] $on_expiry                                      = [],
  Optional[Stdlib::Absolutepath] $dhcpd_binary                     = $dhcp::params::dhcpd_binary
) inherits dhcp::params {
  # check if extra_config is a string, if so convert it to an array
  if $extra_config =~ String {
    $extra_config_real = [$extra_config]
  } else {
    $extra_config_real = $extra_config
  }

  if $dnsdomain {
    $dnsdomain_real = $dnsdomain
  } else {
    if $facts['networking']['domain'] {
      $dnsdomain_real = [$facts['networking']['domain']]
    } else {
      fail('dhcp::dnsdomain must be set and domain fact is missing to use as a default value.')
    }
  }

  if $pxeserver or $pxefilename {
    if ! $pxeserver or ! $pxefilename {
      fail( '$pxeserver and $pxefilename are required when enabling pxe' )
    }
  }

  if $ipxe_filename or $ipxe_bootstrap {
    if ! $ipxe_filename or ! $ipxe_bootstrap {
      fail( '$ipxe_filename and $ipxe_bootstrap are required when enabling ipxe' )
    }
  }

  if $omapi_name or $omapi_key {
    if !$omapi_port or ! $omapi_name or ! $omapi_key or ! $omapi_algorithm {
      fail('$omapi_port, $omapi_name, $omapi_key and $omapi_algorithm are required when defining an OMAPI key')
    }
  }

  # Incase people set interface instead of interfaces work around
  # that. If they set both, use interfaces and the user is a unwise
  # and deserves what they get.
  if $interface != 'NOTSET' and $interfaces == undef {
    $dhcp_interfaces = [$interface]
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

  # Notify service only if manage_service is true
  $service_notify_real = $manage_service ? {
    true    => Service[$servicename],
    default => undef,
  }

  if $manage_package {
    package { $packagename:
      ensure   => installed,
      provider => $package_provider,
    }
  }

  file { $dhcp_dir:
    mode    => '0755',
    require => Package[$packagename],
  }

  case $facts['os']['family'] {
    'RedHat': {
      $use_systemd_service_file = true
    }
    'ArchLinux': {
      $use_systemd_service_file = true
    }
    default: {
      $use_systemd_service_file = false
    }
  }

  if $use_systemd_service_file {
    file { '/etc/systemd/system/dhcpd.service':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => $service_notify_real,
      content => template('dhcp/dhcpd.service'),
    }
  } else {
    # Only debian and ubuntu have this style of defaults for startup.
    case $facts['os']['family'] {
      'Debian': {
        file { '/etc/default/isc-dhcp-server':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          before  => Package[$packagename],
          notify  => $service_notify_real,
          content => template('dhcp/debian/default_isc-dhcp-server'),
        }
      }
      /^(FreeBSD|DragonFly)$/: {
        $interfaces_line = join($dhcp_interfaces, ' ')
        augeas { 'set listen interfaces':
          context => '/files/etc/rc.conf',
          changes => "set dhcpd_ifaces '\"${interfaces_line}\"'",
          before  => Package[$packagename],
          notify  => $service_notify_real,
        }
      }
      default: {}
    }
  }

  Concat { require => Package[$packagename],
    notify => $service_notify_real,
  }

  # dhcpd.conf
  concat { "${dhcp_dir}/${dhcpd_conf_filename}": }
  concat::fragment { 'dhcp-conf-header':
    target  => "${dhcp_dir}/${dhcpd_conf_filename}",
    content => $dhcp_conf_header_real,
    order   => '01',
  }
  concat::fragment { 'dhcp-conf-ntp':
    target  => "${dhcp_dir}/${dhcpd_conf_filename}",
    content => $dhcp_conf_ntp_real,
    order   => '02',
  }
  concat::fragment { 'dhcp-conf-ddns':
    target  => "${dhcp_dir}/${dhcpd_conf_filename}",
    content => $dhcp_conf_ddns_real,
    order   => '10',
  }
  concat::fragment { 'dhcp-conf-pxe':
    target  => "${dhcp_dir}/${dhcpd_conf_filename}",
    content => $dhcp_conf_pxe_real,
    order   => '20',
  }
  concat::fragment { 'dhcp-conf-extra':
    target  => "${dhcp_dir}/${dhcpd_conf_filename}",
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
    order   => '01',
  }

  # dhcpd.hosts
  concat { "${dhcp_dir}/dhcpd.hosts": }
  concat::fragment { 'dhcp-hosts-header':
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => "# static DHCP hosts\n",
    order   => '01',
  }

  # Create any DHCP classes requested
  create_resources('dhcp::dhcp_class', $dhcp_classes)

  # Create any DHCP hosts requested
  create_resources('dhcp::host', $hosts)

  # Ignore any DHCP subnets requested
  create_resources('dhcp::ignoredsubnet', $ignoredsubnets)

  # Setup any DHCP pools for IPv6
  create_resources('dhcp::pool6', $pools6)

  # Setup any DHCP pools for IPv4
  create_resources('dhcp::pool', $pools)

  # Setup any DHCP shared-networks
  $sharednetworks.each |$sharednetwork, $sharednetworkattr| {
    dhcp::sharednetwork { $sharednetwork:
      * => $sharednetworkattr,
    }
  }

  # check if this is really a bool
  if $use_ldap {
    unless $ldap_password {
      fail('you must set $ldap_password')
    }
    unless $ldap_server {
      fail('you must set $ldap_server')
    }
    unless $ldap_username {
      fail('you must set $ldap_username')
    }
    unless $ldap_base_dn {
      fail('you must set $ldap_username')
    }
    concat::fragment { 'dhcp-conf-ldap':
      target  => "${dhcp_dir}/${dhcpd_conf_filename}",
      content => template('dhcp/dhcpd.conf-ldap.erb'),
      order   => '90',
    }
  }

  if $manage_service {
    service { $servicename:
      ensure    => $service_ensure,
      enable    => true,
      hasstatus => true,
      require   => Package[$packagename],
    }
  }
}
