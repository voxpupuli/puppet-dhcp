class dhcp::params {
    $dhcp_dir = $operatingsystem ? {
        debien  => "/etc/dhcp3",
        ubuntu  => "/etc/dhcp3",
        default => "/etc",
    }

    $domain      = 'znet'
    $nameservers = '10.210.18.54, 10.210.18.53'
    $ntpserver   = '10.210.18.1'
    $pxeserver   = '10.210.18.53'
    $filename    = 'pxelinux.0'
    $logfacility = 'local7'
}

