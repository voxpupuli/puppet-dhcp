$ddnskeyname = 'dhcp_updater'

class { 'dhcp':
  dnsdomain    => [
    'example.com',
    '1.1.10.in-addr.arpa',
    ],
  nameservers  => ['10.1.1.10'],
  ntpservers   => ['us.pool.ntp.org'],
  interfaces   => ['eth0'],
  dnsupdatekey => "/etc/bind/keys.d/${ddnskeyname}",
  require      => Bind::Key[ $ddnskeyname ],
  pxeserver    => '10.1.1.5',
  pxefilename  => 'pxelinux.0',
}

dhcp::pool{ 'example.com':
  network => '10.1.1.0',
  mask    => '255.255.255.0',
  range   => '10.1.1.100 10.1.1.200',
  gateway => '10.1.1.1',
}

dhcp::host {
  'gateway':
    mac => '00:11:22:33:44:55',
    ip  => '10.1.1.1',
}
