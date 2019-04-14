# Class: profile::dhcp()
class profile::dhcp(

  String $dns_server,
  String $gateway,
  String $pxe_server,
  Array $interfaces,

){

  notify { "Inside the dhcp class interface: ${interfaces}" : }
  include dhcp

  class { 'dhcp':
    service_ensure => running,
    dnsdomain      => [
      'network.local',
      '0.168.192.in-addr.arpa',
    ],
    nameservers    => [$dns_server],
    ntpservers     => ['192.168.0.1'],
    interfaces     => $interfaces,
    pxeserver      => '192.168.0.132',
    pxefilename    => 'pxelinux.0',
  }

  dhcp::pool {'sn_192.168.0.0' :
    network     => '192.168.0.0',
    mask        => '255.255.255.0',
    range       => '192.168.0.120 192.168.0.140',
    nameservers => [$dns_server],
    gateway     => $gateway,
    pxeserver   => $pxe_server,
    pxefilename => 'pxelinux.0',
  }
}
