# DHCP module for Puppet

[![Build Status](https://travis-ci.org/voxpupuli/puppet-dhcp.png?branch=master)](https://travis-ci.org/voxpupuli/puppet-dhcp)
[![Code Coverage](https://coveralls.io/repos/github/voxpupuli/puppet-dhcp/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet-dhcp)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/dhcp.svg)](https://forge.puppetlabs.com/puppet/dhcp)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/dhcp.svg)](https://forge.puppetlabs.com/puppet/dhcp)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/dhcp.svg)](https://forge.puppetlabs.com/puppet/dhcp)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/dhcp.svg)](https://forge.puppetlabs.com/puppet/dhcp)

## Overview

Installs and manages a DHCP server.

## Features

* Multiple subnet support
* Host reservations
* Secure dynamic DNS updates when combined with Bind
* Can create a dummy (ignored) subnet so that the server can be used only as a
  helper-address target

## Usage

Define the server and the zones it will be responsible for.

```puppet
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
```

### dhcp::pool

Define the pool attributes. This example will create a pool, which serves IPs of
two different ranges in the same network.

May be passed as a hash into the DHCP class.

```puppet
dhcp::pool{ 'ops.dc1.example.net':
  network => '10.0.1.0',
  mask    => '255.255.255.0',
  range   => ['10.0.1.10 10.0.1.100', '10.0.1.200 10.0.1.250' ],
  gateway => '10.0.1.1',
}
```

### dhcp::ignoredsubnet

Define a subnet that will be ignored - useful for making the DHCP server only
respond to requests forwarded by switches etc.

May be passed as a hash into the DHCP class.
```puppet
dhcp::ignoredsubnet{ 'eth0':
  network => '10.0.0.0',
  mask    => '255.255.255.0',
}
```

### dhcp::host

Create host reservations.

May be passed as a hash into the DHCP class.
```puppet
dhcp::host { 'server1':
  comment => 'Optional descriptive comment',
  mac     => '00:50:56:00:00:01',
  ip      => '10.0.1.51',
}
```

### parameters

Parameters are available to configure pxe or ipxe

Boot ipxe from pxe. When configured this overrides pxefilename.
For more information see [ipxe.org](http://ipxe.org/howto/chainloading).

```puppet
class { 'dhcp':
  ipxe_filename  => 'undionly.kpxe',
  ipxe_bootstrap => 'bootstrap.kpxe',
  pxeserver      => '10.0.1.50',
}
```

The following is the list of all parameters available for this class.

| Parameter              | Data Type | Default Value                     |
| :--------------------- | :-------: | :-------------------------------- |
| `authoritative`        | Boolean   | `true`                            |
| `ddns_update_static`   | String    | `'on'`                            |
| `ddns_update_style`    | String    | `'interim'`                       |
| `ddns_update_optimize` | String    | `'on'`                            |
| `default_lease_time`   | Integer   | `43200`                           |
| `dhcp_conf_ddns`       | String    | `'INTERNAL_TEMPLATE'`             |
| `dhcp_conf_extra`      | String    | `'INTERNAL_TEMPLATE'`             |
| `dhcp_conf_fragments`  | Hash      | `{}`                              |
| `dhcp_conf_header`     | String    | `'INTERNAL_TEMPLATE'`             |
| `dhcp_conf_ntp`        | String    | `'INTERNAL_TEMPLATE'`             |
| `dhcp_conf_pxe`        | String    | `'INTERNAL_TEMPLATE'`             |
| `dhcp_dir`             | String    | `$dhcp::params::dhcp_dir`         |
| `dhcpd_conf_filename`  | String    | `'dhcpd.conf'`                    |
| `dnsdomain`            | Array     | `undef`                           |
| `dnskeyname`           | String    | `undef`                           |
| `dnssearchdomains`     | Array     | `[]`                              |
| `dnsupdatekey`         | String    | `undef`                           |
| `extra_config`         | String    | `''`                              |
| `globaloptions`        | String    | `''`                              |
| `interface`            | String    | `'NOTSET'`                        |
| `interfaces`           | Array     | `undef`                           |
| `ipxe_bootstrap`       | String    | `undef`                           |
| `ipxe_filename`        | String    | `undef`                           |
| `ldap_base_dn`         | String    | `'dc=example, dc=com'`            |
| `ldap_debug_file`      | String    | `undef`                           |
| `ldap_method`          | String    | `'dynamic'`                       |
| `ldap_password`        | String    | `''`                              |
| `ldap_port`            | Integer   | `389`                             |
| `ldap_server`          | String    | `'localhost'`                     |
| `ldap_username`        | String    | `'cn=root, dc=example, dc=com'`   |
| `logfacility`          | String    | `'daemon'`                        |
| `manage_service`       | Boolean   | `true`                       |
| `max_lease_time`       | Integer   | `86400`                           |
| `mtu`                  | Integer   | `undef`                           |
| `nameservers`          | Array     | `[ '8.8.8.8', '8.8.4.4' ]`        |
| `nameservers_ipv6`     | Array     | `[]`                              |
| `ntpservers`           | Array     | `[]`                              |
| `omapi_algorithm`      | String    | `HMAC-MD5`                        |
| `omapi_key`            | String    | `undef`                           |
| `omapi_name`           | String    | `undef`                           |
| `omapi_port`           | Integer   | `undef`                           |
| `option_code150_label` | String    | `pxegrub`                         |
| `option_code150_value` | String    | `text`                            |
| `package_provider`     | String    | `$dhcp::params::package_provider` |
| `packagename`          | String    | `$dhcp::params::packagename`      |
| `pxefilename`          | String    | `undef`                           |
| `pxeserver`            | String    | `undef`                           |
| `service_ensure`       | Enum      | `running`                         |
| `servicename`          | String    | `$dhcp::params::servicename`      |
| `use_ldap`             | Boolean   | `false`                           |
| `dhcp_classes`         | Hash      | `{}`                              |
| `hosts`                | Hash      | `{}`                              |
| `ignoredsubnets`       | Hash      | `{}`                              |
| `pools`                | Hash      | `{}`                              |
| `pools6`               | Hash      | `{}`                              |

## Contributors

Zach Leslie <zach.leslie@gmail.com>
Ben Hughes <git@mumble.org.uk>
Sam Dunster <sdunster@uow.edu.au>
Garrett Honeycutt <gh@learnpuppet.com>
Matt Kirby <mk.kirby@gmail.com>
