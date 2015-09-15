2015-09-15 Release 0.4.0

Backwards incompatible changes:
- Updated to set `ddns-hostname` instead of `option host-name`.

Features:
- Adds ability to ignore subnets.
- Adds service_ensure to manage state of dhcp service.
- Allows users to specify different nameservers and PXE-server.
- ALlows overriding of the domain name per pool.
- Modernizes module with lint, testing, metadata updates.
- Allows adding of abitrary global options to the main `dhcpd.conf`.
- Allows additional options to be specified for `dhcp::host`.
- Allows setting of the `dnskeyname` parameter in `dhcpd.conf`.
- Adds ability to define `omapi_port`.
- Adds ability to ignore unknown-clients.

Bugfixes:
- Normalizes MAC addresses to be printed in upper case.
- Fixes default ntpservers value to not fail validation.
- Fix in documentation for dhcp::pool. range should be array instead of string.
- Fixes dhcpd.conf file dependency error.
- Fix to properly wrap `domain-name` in quotes.

2014-07-23 Release 0.3.0

Backwards incompatible changes:
- Now requires puppetlabs/concat >= 1.1.0

Features:
- Allow gateway to be unset for private networks
- Add sysconfig dhcpd file for RedHat based systems

Bugfixes:
- Remove deprecated concat::setup
- Update templates to remove deprecation warnings
- Ensure $dhcp_dir exists

2014-03-25 Release 0.2.0

Backwards incompatible changes:
- Update concat dependency to puppetlabs/concat
- Depend on puppetlabs/stdlib

Features:
- Allow ntpservers in dhcp.conf to be optional
- Add redhat/fedora/centos package and service names
- Make dhcp::pool range parameter optional

Bugfixes:
- Add unit tests
- Add apache license file
- Remove erronious failover parameter from base class
