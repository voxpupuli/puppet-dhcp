class dhcp::params {

    $dhcp_dir = $operatingsystem ? {
        debian  => "/etc/dhcp",
        ubuntu  => "/etc/dhcp3",
        darwin  => "/opt/local/etc/dhcp",
        default => "/etc",
    }

    #     $domain      = 'znet'
    #     $nameservers = '10.210.18.51, 10.210.18.1'
    #     $ntpserver   = '10.210.18.1'
    #     $pxeserver   = '10.210.18.53'
    #     $filename    = 'pxelinux.0'
    #     $logfacility = 'local7'

    $packagename = $operatingsystem ? {
      darwin  => "dhcp",
      default => "isc-dhcp-server",
    }

    $servicename = $operatingsystem ? {
      darwin  => "org.macports.dhcpd",
      default => "isc-dhcp-server",
    }
}
