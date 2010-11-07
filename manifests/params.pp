class dhcp::params {
    $dhcp_dir = $operatingsystem ? {
        debien => "/etc/dhcp3",
        ubuntu => "/etc/dhcp3",
        default => "/etc",
    }

    $domain = 'znet.local'
    $nameservers = '10.210.18.51'
    $ntpserver = '10.210.18.253'
    $pxeserver = '10.210.18.50'
    $filename = 'pxelinux.0'
    $logfacility = 'local7'
}

