class dhcp::params {
    $dhcp_dir = $operatingsystem ? {
        debien => "/etc/dhcp3",
        ubuntu => "/etc/dhcp3",
        default => "/etc",
    }

    $domain = 'zlan'
    $nameservers = '10.210.18.10'
    $ntpserver = '10.210.18.10'
    $pxeserver = '10.210.18.32'
    $filename = 'pxelinux.0'
    $logfacility = 'local7'
}

