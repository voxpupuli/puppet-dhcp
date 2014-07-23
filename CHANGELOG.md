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
