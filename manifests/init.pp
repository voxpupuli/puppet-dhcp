class dhcp {
    include dhcp::params

    $dhcp_dir = $dhcp::params::dhcp_dir
    $domain = $dhcp::params::domain
    $nameservers = $dhcp::params::nameservers
    $ntpserver = $dhcp::params::ntpserver
    $pxeserver = $dhcp::params::pxeserver
    $filename = $dhcp::params::filename
    $logfacility = $dhcp::params::logfacility

	package {
		"dhcp": 
			name => $operatingsystem ? {
				debian => "dhcp3-server",
				ubuntu => "dhcp3-server",
				default => "dhcp",
			},
			ensure => installed;
	}

	iptables { "dhcp":
		proto => "udp",
		dport => "67",
		jump => "ACCEPT",
	}
	
	file {
		"${dhcp_dir}/dhcpd.conf":
			owner	=> root,
			group	=> root,
			mode	=> 644,
			require	=> Package["dhcp"],
			#notify	=> Service["dhcpd"],
			content	=> template("dhcp/dhcpd.conf.erb");
	#	"dhcp3-server":
	#		owner		=> root,
	#		group		=> root,
	#		mode		=> 644,
	#		require  => Package["dhcp3-server"],
	#		notify   => Service["dhcpd"],
	#		path     => "/etc/default/dhcp3-server",
	#		source	=> "puppet:///modules/dhcp/dhcp3-server";
	}
	#
	
	include concat::setup
	concat { "${dhcp_dir}/dhcpd.pools": }
	concat { "${dhcp_dir}/dhcpd.hosts": }
   
   service {
      "dhcpd":
         enable    => "true",
         ensure    => "running",
         subscribe => [Concat["${dhcp_dir}/dhcpd.pools"], Concat["${dhcp_dir}/dhcpd.hosts"], File["${dhcp_dir}/dhcpd.conf"]],
         require   => Package["dhcp"];
   }

            
}

