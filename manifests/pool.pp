define dhcp::pool ($network,$mask,$range,$gateway) {
    include dhcp
    include dhcp::params

    $dhcp_dir = $dhcp::params::dhcp_dir

    #file {
    #    "${dhcp_dir}/$name.pool":

    Fragment { target => 'dhcpd.pools', path => $dhcp_dir }
    fragment {
        "dhcp_${name}":
            order => '10',
            content => template("dhcp/dhcpd.pool.erb");
    }
    
    fragment::concat { 'dhcpd.pools':
        owner => 'root',
        group => 'root',
        mode  => '0640',
        path  => "${dhcp_dir}/dhcpd.pools";
    }

}

