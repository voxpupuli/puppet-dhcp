# @summary Manage a DHCP class in the config
define dhcp::dhcp_class (
  Variant[Array[String[1]], String[1]] $parameters,
) {
  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_class_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.class.erb'),
    order   => '50',
  }
}
