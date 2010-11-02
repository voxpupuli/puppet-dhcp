define dhcp::host ($host,$ip,$mac) {
    include dhcp
    include dhcp::params
    
    Fragment { target => 'dhcpd.hosts', path => $dhcp_dir }
    fragment {
        "dhcp_host_${name}":
            order => '10',
            content => template("dhcp/dhcpd.host.erb");
    }

    fragment::concat { 'dhcpd.hosts':
        owner => 'root',
        group => 'root',
        mode  => '0640',
        path  => "${dhcp_dir}/dhcpd.hosts";
    }

}
