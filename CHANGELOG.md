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
