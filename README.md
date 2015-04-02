# DHCP module for Puppet
Installs and manages a DHCP server.

## Features
* Multiple subnet support
* Host reservations
* Secure dynamic DNS updates when combined with Bind
* Can create a dummy (ignored) subnet so that the server can be used only as a helper-address target

## Usage
Define the server and the zones it will be responsible for.

    class { 'dhcp':
      service_ensure => running,
      dnsdomain      => [
        'dc1.example.net',
        '1.0.10.in-addr.arpa',
      ],
      nameservers  => ['10.0.1.20'],
      ntpservers   => ['us.pool.ntp.org'],
      interfaces   => ['eth0'],
      dnsupdatekey => '/etc/bind/keys.d/rndc.key',
      dnskeyname   => 'rndc-key',
      require      => Bind::Key['rndc-key'],
      pxeserver    => '10.0.1.50',
      pxefilename  => 'pxelinux.0',
      omapi_port   => 7911,
    }

### dhcp::pool
Define the pool attributes

    dhcp::pool{ 'ops.dc1.example.net':
      network => '10.0.1.0',
      mask    => '255.255.255.0',
      range   => ['10.0.1.100', '10.0.1.200'],
      gateway => '10.0.1.1',
    }

### dhcp::ignoredsubnet
Define a subnet that will be ignored - useful for making the DHCP server only respond to
requests forwarded by switches etc.

    dhcp::ignoredsubnet{ 'eth0':
      network => '10.0.0.0',
      mask    => '255.255.255.0',
    }


### dhcp::host
Create host reservations.

    dhcp::host { 'server1':
      mac => '00:50:56:00:00:01',
      ip  => '10.0.1.51',
    }

## Contributors
Zach Leslie <zach.leslie@gmail.com>
Ben Hughes <git@mumble.org.uk>
Sam Dunster <sdunster@uow.edu.au>
Garrett Honeycutt <gh@learnpuppet.com>
