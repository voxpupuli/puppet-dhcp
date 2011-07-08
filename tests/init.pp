dhcp::pool {
  "supernet.lan":
    network  => "192.168.1.0",
    mask     => "255.255.255.0",
    range    => "192.168.1.150 192.168.1.199",
    gateway  => "192.168.1.1";
}

dhcp::host {
  'server1.supernet.lan':
    mac => "00:00:00:00:00:00",
    ip  => "192.168.1.10";
}
