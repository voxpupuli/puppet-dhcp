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
			content	=> tempalte("dhcp/dhcpd.conf.erb");
	#	"dhcp3-server":
	#		owner		=> root,
	#		group		=> root,
	#		mode		=> 644,
	#		require  => Package["dhcp3-server"],
	#		notify   => Service["dhcpd"],
	#		path     => "/etc/default/dhcp3-server",
	#		source	=> "puppet:///modules/dhcp/dhcp3-server";
	#	"dhcpd.pools":
	#		owner		=> root,
	#		group		=> root,
	#		mode		=> 644,
	#		require  => Package["dhcp3-server"],
	#		notify   => Service["dhcpd"],
	#		path     => "/etc/dhcp3/dhcpd.pools",
	#		source	=> "puppet:///modules/dhcp/dhcpd.pools";
	#	"dhcpd.hosts":
	#		owner		=> root,
	#		group		=> root,
	#		mode		=> 644,
	#		require  => Package["dhcp3-server"],
	#		notify   => Service["dhcpd"],
	#		path     => "/etc/dhcp3/dhcpd.hosts",
	#		source	=> "puppet:///modules/dhcp/dhcpd.hosts";
	}
	#
	#include dhcp::service

            
}

