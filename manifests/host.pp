define dhcp::host ($host,$ip,$mac) {
    include dhcp
    include dhcp::params
    
    fragment {
        "dhcp_host_${name}":
	    target => 'dhcpd.hosts',
	    path => "$dhcp_dir",
            order => '10',
            content => template("dhcp/dhcpd.host.erb");
    }

}
