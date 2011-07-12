define dhcp::host (
    $ip,
    $mac,
    $comment=''
  ) {

  $host = $name
  # include dhcp
  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_host_${name}":
      target  => "${dhcp_dir}/dhcpd.hosts",
      content => template("dhcp/dhcpd.host.erb"),
      order   => 10,
  }
}

