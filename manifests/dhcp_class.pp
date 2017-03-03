# == Define: dhcp::dhcp_class
#
define dhcp::dhcp_class (
  Variant[Array[String], String] $parameters,
) {
  include ::dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_class_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.class.erb'),
    order   => '50',
  }
}
