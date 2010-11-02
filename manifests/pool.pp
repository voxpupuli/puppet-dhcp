define dhcp::pool ($network,$mask,$range,$gateway) {
    include dhcp
    include dhcp::params

    $dhcp_dir = $dhcp::params::dhcp_dir

    fragment {
        "dhcp_${name}":
	    target => 'dhcpd.pools',
	    path => "$dhcp_dir",
            content => template("dhcp/dhcpd.pool.erb");
    }
    
}

