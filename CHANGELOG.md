# Changelog

## 2017-01-12 - Release 1.1.0

Last release with Puppet 3 support!
* Clarify test names
* RuboCop fixes
* Add dhcpd_conf_filename param
* Document the define in manifests/ignoredsubnet.pp
* Add spec test for alternate conf filename
* Add ipv6 nameservers param
* Add dhcp6.name-servers option to pool.pp
* Add dhcp::pool6
* Add ddns_update_static & ddns_update_optimize params
* Fix several markdown issues
* Add missing badges
* Deny dynamic bootp clients if failover is set
* Parameterize option code 150
* Set puppet min version_requirement to 3.8.7

## 2016-09-26 - Release 1.0.1

* Modulesync with latest Vox Pupuli defaults
* Feature: Add ability to configure the MTU
* Feature: Allow for a DHCP host to be ignored so it can be handled
  by another DHCP server in the same subnet
* Fix: Documentation on pool ranges was confusing
* Fix: Relax the concat version constraint to include version 2
* Fix: A number of additional parameters are now type checked

## 2016-08-18 - Release 1.0.0

* Modulesync with latest Vox Pupuli defaults
* Feature: Add optional "comment" field to host template
* Feature: Add Arch Linux support
* Feature: Add support for LDAP backend
* Feature: Use ISC default for default_lease_time
* Feature: Add option dns search domain
* Fix: Work around notification problem with concat resources


## 2016-05-22 - Release 0.5.0

* First release in the voxpupuli namespace
* Drop Ruby1.8 support
* Add support for STRICT_VARIABLES
* modulesync with latest voxpupuli defaults
* do not sort pool dns servers list
* add generic support for custom config options
* Add support for iPXE chain loading
* Fix wrong fact values in case blocks (init.pp/params.pp)


## 2015-09-15 - Release 0.4.0

Backwards incompatible changes:
* Updated to set `ddns-hostname` instead of `option host-name`.

Features:
* Adds ability to ignore subnets.
* Adds service_ensure to manage state of dhcp service.
* Allows users to specify different nameservers and PXE-server.
* ALlows overriding of the domain name per pool.
* Modernizes module with lint, testing, metadata updates.
* Allows adding of abitrary global options to the main `dhcpd.conf`.
* Allows additional options to be specified for `dhcp::host`.
* Allows setting of the `dnskeyname` parameter in `dhcpd.conf`.
* Adds ability to define `omapi_port`.
* Adds ability to ignore unknown-clients.

Bugfixes:
* Normalizes MAC addresses to be printed in upper case.
* Fixes default ntpservers value to not fail validation.
* Fix in documentation for dhcp::pool. range should be array instead of string.
* Fixes dhcpd.conf file dependency error.
* Fix to properly wrap `domain-name` in quotes.


## 2014-07-23 - Release 0.3.0

Backwards incompatible changes:
* Now requires puppetlabs/concat >= 1.1.0

Features:
* Allow gateway to be unset for private networks
* Add sysconfig dhcpd file for RedHat based systems

Bugfixes:
* Remove deprecated concat::setup
* Update templates to remove deprecation warnings
* Ensure $dhcp_dir exists


## 2014-03-25 - Release 0.2.0

Backwards incompatible changes:
* Update concat dependency to puppetlabs/concat
* Depend on puppetlabs/stdlib

Features:
* Allow ntpservers in dhcp.conf to be optional
* Add redhat/fedora/centos package and service names
* Make dhcp::pool range parameter optional

Bugfixes:
* Add unit tests
* Add apache license file
* Remove erronious failover parameter from base class
