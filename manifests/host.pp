define dhcp::host ($host,$ip,$mac) {
    include dhcp
    include dhcp::params

    $dhcp_dir = $dhcp::params::dhcp_dir

    concat::fragment {
        "dhcp_host_${name}":
            target => "${dhcp_dir}/dhcpd.hosts",
            #path => "$dhcp_dir",
            content => template("dhcp/dhcpd.host.erb");
    }
}

