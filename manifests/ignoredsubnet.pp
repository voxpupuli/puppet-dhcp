define dhcp::ignoredsubnet (
  $network,
  $mask,
) {
  if ! defined(Class['dhcp']) {
    fail('You must include the dhcp base class before using any dhcp defined resources')
  }

  concat::fragment { "dhcp_ignoredsubnet_${name}":
    target  => "${::dhcp::dhcp_dir}/dhcpd.ignoredsubnets",
    content => template('dhcp/dhcpd.ignoredsubnet.erb'),
  }
}

