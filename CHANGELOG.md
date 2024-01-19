# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v6.1.0](https://github.com/voxpupuli/puppet-dhcp/tree/v6.1.0) (2024-01-19)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v6.0.0...v6.1.0)

**Implemented enhancements:**

- Add OracleLinux/Alma/Rocky support [\#281](https://github.com/voxpupuli/puppet-dhcp/pull/281) ([bastelfreak](https://github.com/bastelfreak))
- Add Puppet 8 support [\#276](https://github.com/voxpupuli/puppet-dhcp/pull/276) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- README.md: Update badges [\#282](https://github.com/voxpupuli/puppet-dhcp/pull/282) ([bastelfreak](https://github.com/bastelfreak))

## [v6.0.0](https://github.com/voxpupuli/puppet-dhcp/tree/v6.0.0) (2023-12-11)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v5.0.1...v6.0.0)

**Breaking changes:**

- Drop Puppet 6 support [\#273](https://github.com/voxpupuli/puppet-dhcp/pull/273) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Support for puppetlabs/stdlib 9.x, concat 9.x, Debian 12, and Ubuntu 22.04 [\#278](https://github.com/voxpupuli/puppet-dhcp/pull/278) ([mj](https://github.com/mj))
- Add CentOS Stream 9 and RHEL 9 support [\#272](https://github.com/voxpupuli/puppet-dhcp/pull/272) ([tobias-urdin](https://github.com/tobias-urdin))

## [v5.0.1](https://github.com/voxpupuli/puppet-dhcp/tree/v5.0.1) (2022-11-03)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v5.0.0...v5.0.1)

**Fixed bugs:**

- Fix the type of options and parameters in pool manifest [\#267](https://github.com/voxpupuli/puppet-dhcp/pull/267) ([alexshyriaiev](https://github.com/alexshyriaiev))

## [v5.0.0](https://github.com/voxpupuli/puppet-dhcp/tree/v5.0.0) (2022-05-10)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v4.0.1...v5.0.0)

**Breaking changes:**

- Drop support for Puppet 5 [\#256](https://github.com/voxpupuli/puppet-dhcp/pull/256) ([smortex](https://github.com/smortex))
- Drop support for CentOS/RedHat 6, Debian 8,9 and Ubuntu 16.04 [\#254](https://github.com/voxpupuli/puppet-dhcp/pull/254) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- allow to override host-subnetmask for pools [\#262](https://github.com/voxpupuli/puppet-dhcp/pull/262) ([sircubbi](https://github.com/sircubbi))
- Add support for grouping of dhcp-pools into shared-networks [\#261](https://github.com/voxpupuli/puppet-dhcp/pull/261) ([sircubbi](https://github.com/sircubbi))
- Add support for Puppet 7 [\#257](https://github.com/voxpupuli/puppet-dhcp/pull/257) ([smortex](https://github.com/smortex))
- Add support for Debian 11, Ubuntu 20.04 [\#255](https://github.com/voxpupuli/puppet-dhcp/pull/255) ([smortex](https://github.com/smortex))
- Extend support for event clauses to global, pool and pool6 [\#252](https://github.com/voxpupuli/puppet-dhcp/pull/252) ([mergwyn](https://github.com/mergwyn))

**Fixed bugs:**

- rename fragments for dhcp6-pools [\#263](https://github.com/voxpupuli/puppet-dhcp/pull/263) ([sircubbi](https://github.com/sircubbi))

**Closed issues:**

- Add event handlers to main and pool config - Enhancement  [\#251](https://github.com/voxpupuli/puppet-dhcp/issues/251)
- Add support of shared-network option [\#158](https://github.com/voxpupuli/puppet-dhcp/issues/158)

**Merged pull requests:**

- Bugfix: use correct title in shared-network dependency [\#264](https://github.com/voxpupuli/puppet-dhcp/pull/264) ([sircubbi](https://github.com/sircubbi))
- Allow filename and iPXE configuration in dhcp host entries [\#259](https://github.com/voxpupuli/puppet-dhcp/pull/259) ([tom-krieger](https://github.com/tom-krieger))
- Allow up-to-date dependencies [\#253](https://github.com/voxpupuli/puppet-dhcp/pull/253) ([smortex](https://github.com/smortex))
- Resolve puppet-lint notices [\#248](https://github.com/voxpupuli/puppet-dhcp/pull/248) ([jcpunk](https://github.com/jcpunk))

## [v4.0.1](https://github.com/voxpupuli/puppet-dhcp/tree/v4.0.1) (2020-08-23)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v4.0.0...v4.0.1)

**Fixed bugs:**

- pxeserver parameter no longer supports hostnames, only IP address [\#239](https://github.com/voxpupuli/puppet-dhcp/issues/239)
- Allow indefinite lease times to be set [\#246](https://github.com/voxpupuli/puppet-dhcp/pull/246) ([alexjfisher](https://github.com/alexjfisher))

**Merged pull requests:**

- Use voxpupuli-acceptance [\#242](https://github.com/voxpupuli/puppet-dhcp/pull/242) ([ekohl](https://github.com/ekohl))

## [v4.0.0](https://github.com/voxpupuli/puppet-dhcp/tree/v4.0.0) (2020-02-24)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v3.4.0...v4.0.0)

**Breaking changes:**

- drop Ubuntu 14.04 support [\#229](https://github.com/voxpupuli/puppet-dhcp/pull/229) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 2.5.1 & drop Puppet 4 [\#218](https://github.com/voxpupuli/puppet-dhcp/pull/218) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add support for RHEL/CentOS 8 and Debian 10 [\#235](https://github.com/voxpupuli/puppet-dhcp/pull/235) ([dhoppe](https://github.com/dhoppe))
- Improve datatypes [\#219](https://github.com/voxpupuli/puppet-dhcp/pull/219) ([bastelfreak](https://github.com/bastelfreak))
- allow dhcp::host to set "on EVENT" handlers [\#216](https://github.com/voxpupuli/puppet-dhcp/pull/216) ([jflorian](https://github.com/jflorian))
- allow dhcp::host to override default- and max-lease-time [\#215](https://github.com/voxpupuli/puppet-dhcp/pull/215) ([jflorian](https://github.com/jflorian))
- update FreeBSD pkg name [\#211](https://github.com/voxpupuli/puppet-dhcp/pull/211) ([mmoll](https://github.com/mmoll))
- Allow host declaration without IP. [\#210](https://github.com/voxpupuli/puppet-dhcp/pull/210) ([mergwyn](https://github.com/mergwyn))

**Fixed bugs:**

- Allow puppetlabs/concat 6.x, puppetlabs/stdlib 6.x [\#225](https://github.com/voxpupuli/puppet-dhcp/pull/225) ([dhoppe](https://github.com/dhoppe))
- set dhcpd\_ifaces in rc.conf on FreeBSD [\#212](https://github.com/voxpupuli/puppet-dhcp/pull/212) ([mmoll](https://github.com/mmoll))

**Closed issues:**

- Ubuntu 18.04 Interfaces not set [\#200](https://github.com/voxpupuli/puppet-dhcp/issues/200)
- Insert possibility to enable host declaration without IP. [\#106](https://github.com/voxpupuli/puppet-dhcp/issues/106)
- Configure dhcpd\_ifaces in rc.conf on FreeBSD [\#88](https://github.com/voxpupuli/puppet-dhcp/issues/88)

**Merged pull requests:**

- update repo links to https [\#236](https://github.com/voxpupuli/puppet-dhcp/pull/236) ([bastelfreak](https://github.com/bastelfreak))
- Remove duplicate CONTRIBUTING.md file [\#231](https://github.com/voxpupuli/puppet-dhcp/pull/231) ([dhoppe](https://github.com/dhoppe))
- drop Ubuntu 14.04 CI testing [\#230](https://github.com/voxpupuli/puppet-dhcp/pull/230) ([bastelfreak](https://github.com/bastelfreak))
- Update minimum stdlib version to 4.25.0 and use some of the newer types [\#217](https://github.com/voxpupuli/puppet-dhcp/pull/217) ([alexjfisher](https://github.com/alexjfisher))
- Add parameter to make installing the package optional [\#214](https://github.com/voxpupuli/puppet-dhcp/pull/214) ([dgivens](https://github.com/dgivens))

## [v3.4.0](https://github.com/voxpupuli/puppet-dhcp/tree/v3.4.0) (2018-12-19)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v3.3.0...v3.4.0)

**Implemented enhancements:**

- add mac address validation [\#205](https://github.com/voxpupuli/puppet-dhcp/pull/205) ([tiernap](https://github.com/tiernap))
- add debian 9 support [\#197](https://github.com/voxpupuli/puppet-dhcp/pull/197) ([bastelfreak](https://github.com/bastelfreak))
- add ubuntu 18.04 support [\#196](https://github.com/voxpupuli/puppet-dhcp/pull/196) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Don't add a newline between each DHCP option [\#207](https://github.com/voxpupuli/puppet-dhcp/pull/207) ([bastelfreak](https://github.com/bastelfreak))
- Purge useless trailing whitespace in template [\#206](https://github.com/voxpupuli/puppet-dhcp/pull/206) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- make main section nameservers optional [\#204](https://github.com/voxpupuli/puppet-dhcp/pull/204) ([SourceDoctor](https://github.com/SourceDoctor))
- modulesync 2.1.0 and allow puppet 6.x [\#199](https://github.com/voxpupuli/puppet-dhcp/pull/199) ([bastelfreak](https://github.com/bastelfreak))
- fix wrong version schema in metadata.json [\#198](https://github.com/voxpupuli/puppet-dhcp/pull/198) ([bastelfreak](https://github.com/bastelfreak))
- enable acceptance tests [\#195](https://github.com/voxpupuli/puppet-dhcp/pull/195) ([bastelfreak](https://github.com/bastelfreak))

## [v3.3.0](https://github.com/voxpupuli/puppet-dhcp/tree/v3.3.0) (2018-09-07)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v3.2.0...v3.3.0)

**Implemented enhancements:**

- Use IPv6 type validation for $nameservers\_ipv6 [\#186](https://github.com/voxpupuli/puppet-dhcp/pull/186) ([ekohl](https://github.com/ekohl))

**Fixed bugs:**

- Debian default ipv4 interfaces config has changed [\#189](https://github.com/voxpupuli/puppet-dhcp/pull/189) ([vStone](https://github.com/vStone))
- Enclosing the omapi secret parameter in "quotes" is a syntax error [\#179](https://github.com/voxpupuli/puppet-dhcp/pull/179) ([infracaninophile](https://github.com/infracaninophile))

**Closed issues:**

- INTERFACES default option deprecated on Debian 9 [\#177](https://github.com/voxpupuli/puppet-dhcp/issues/177)

**Merged pull requests:**

- allow puppetlabs/concat 5.x [\#193](https://github.com/voxpupuli/puppet-dhcp/pull/193) ([bastelfreak](https://github.com/bastelfreak))
- allow puppetlabs/stdlib 5.x [\#191](https://github.com/voxpupuli/puppet-dhcp/pull/191) ([bastelfreak](https://github.com/bastelfreak))
- Remove docker nodesets [\#183](https://github.com/voxpupuli/puppet-dhcp/pull/183) ([bastelfreak](https://github.com/bastelfreak))
- drop EOL OSs; fix puppet version range [\#181](https://github.com/voxpupuli/puppet-dhcp/pull/181) ([bastelfreak](https://github.com/bastelfreak))

## [v3.2.0](https://github.com/voxpupuli/puppet-dhcp/tree/v3.2.0) (2018-01-04)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v3.1.0...v3.2.0)

**Implemented enhancements:**

- add ddns\_client\_updates parameter [\#172](https://github.com/voxpupuli/puppet-dhcp/pull/172) ([tiernap](https://github.com/tiernap))

**Closed issues:**

- Could not find dependent Service\[dhcpd\] for File\[/etc/systemd/system/dhcpd.service\] when manage\_service is false [\#170](https://github.com/voxpupuli/puppet-dhcp/issues/170)

**Merged pull requests:**

- release 3.2.0 [\#176](https://github.com/voxpupuli/puppet-dhcp/pull/176) ([bastelfreak](https://github.com/bastelfreak))
- Use match\_array for better failure output [\#173](https://github.com/voxpupuli/puppet-dhcp/pull/173) ([ekohl](https://github.com/ekohl))
- Fix notification target [\#171](https://github.com/voxpupuli/puppet-dhcp/pull/171) ([danyel2014](https://github.com/danyel2014))

## [v3.1.0](https://github.com/voxpupuli/puppet-dhcp/tree/v3.1.0) (2017-11-11)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v3.0.0...v3.1.0)

**Merged pull requests:**

- release 3.1.0 [\#168](https://github.com/voxpupuli/puppet-dhcp/pull/168) ([bastelfreak](https://github.com/bastelfreak))
- dhcpd.conf-extra: move includes below extra\_config [\#166](https://github.com/voxpupuli/puppet-dhcp/pull/166) ([aquister](https://github.com/aquister))
- dhcp::failover parameter scope fix [\#165](https://github.com/voxpupuli/puppet-dhcp/pull/165) ([aquister](https://github.com/aquister))
- parameterised ddns-hostnames [\#164](https://github.com/voxpupuli/puppet-dhcp/pull/164) ([tiernap](https://github.com/tiernap))
- Use dhcpd\_conf\_filename param [\#163](https://github.com/voxpupuli/puppet-dhcp/pull/163) ([aquister](https://github.com/aquister))

## [v3.0.0](https://github.com/voxpupuli/puppet-dhcp/tree/v3.0.0) (2017-10-18)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v2.1.0...v3.0.0)

**Breaking changes:**

- Write a systemd service file when using systemd [\#154](https://github.com/voxpupuli/puppet-dhcp/pull/154) ([petems](https://github.com/petems))

**Implemented enhancements:**

- use parameter for dhcpd binary path in unit file [\#161](https://github.com/voxpupuli/puppet-dhcp/pull/161) ([bastelfreak](https://github.com/bastelfreak))
- Replace legacy facts with facts hash [\#160](https://github.com/voxpupuli/puppet-dhcp/pull/160) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- Release 3.0.0 [\#162](https://github.com/voxpupuli/puppet-dhcp/pull/162) ([bastelfreak](https://github.com/bastelfreak))

## [v2.1.0](https://github.com/voxpupuli/puppet-dhcp/tree/v2.1.0) (2017-09-27)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v2.0.0...v2.1.0)

**Implemented enhancements:**

- Update $extra\_config to work with arrays and not only strings [\#156](https://github.com/voxpupuli/puppet-dhcp/pull/156) ([bastelfreak](https://github.com/bastelfreak))
- Support SmartOS [\#155](https://github.com/voxpupuli/puppet-dhcp/pull/155) ([petems](https://github.com/petems))

**Merged pull requests:**

- release 2.1.0 [\#159](https://github.com/voxpupuli/puppet-dhcp/pull/159) ([bastelfreak](https://github.com/bastelfreak))
- Add breaking changes section to the changelog [\#153](https://github.com/voxpupuli/puppet-dhcp/pull/153) ([bastelfreak](https://github.com/bastelfreak))

## [v2.0.0](https://github.com/voxpupuli/puppet-dhcp/tree/v2.0.0) (2017-06-15)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v1.1.0...v2.0.0)

**Breaking changes:**

- modulesync 0.17.0 and drop puppet3 support [\#138](https://github.com/voxpupuli/puppet-dhcp/pull/138) ([bastelfreak](https://github.com/bastelfreak))

**Closed issues:**

- Update FreeBSD DHCP version to 4.3 [\#94](https://github.com/voxpupuli/puppet-dhcp/issues/94)
- Add pools/hosts parameters for create\_resources\(\) [\#91](https://github.com/voxpupuli/puppet-dhcp/issues/91)
- Add OMAPI key configuration [\#90](https://github.com/voxpupuli/puppet-dhcp/issues/90)
- Add define for specifying DHCP classes [\#86](https://github.com/voxpupuli/puppet-dhcp/issues/86)

**Merged pull requests:**

- release 2.0.0 [\#152](https://github.com/voxpupuli/puppet-dhcp/pull/152) ([bastelfreak](https://github.com/bastelfreak))
- FreeBSD uses ISC DHCP 4.3 now [\#149](https://github.com/voxpupuli/puppet-dhcp/pull/149) ([ekohl](https://github.com/ekohl))
- Fix dhcp::ignoredsubnet template [\#148](https://github.com/voxpupuli/puppet-dhcp/pull/148) ([ekohl](https://github.com/ekohl))
- Add flag to manage dhcp service [\#147](https://github.com/voxpupuli/puppet-dhcp/pull/147) ([spacedog](https://github.com/spacedog))
- Added resource args for use with an ENC [\#146](https://github.com/voxpupuli/puppet-dhcp/pull/146) ([jcpunk](https://github.com/jcpunk))
- migrate to puppet4 datatypes [\#144](https://github.com/voxpupuli/puppet-dhcp/pull/144) ([bastelfreak](https://github.com/bastelfreak))
- Add dhcp\_class define to create custom DHCP class [\#142](https://github.com/voxpupuli/puppet-dhcp/pull/142) ([domcleal](https://github.com/domcleal))
- Add omapi\_name, key, algorithm parameters [\#141](https://github.com/voxpupuli/puppet-dhcp/pull/141) ([domcleal](https://github.com/domcleal))

## [v1.1.0](https://github.com/voxpupuli/puppet-dhcp/tree/v1.1.0) (2017-01-12)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v1.0.1...v1.1.0)

**Merged pull requests:**

- release 1.1.0 [\#137](https://github.com/voxpupuli/puppet-dhcp/pull/137) ([bastelfreak](https://github.com/bastelfreak))
- Set puppet min version\_requirement to 3.8.7 + deps [\#132](https://github.com/voxpupuli/puppet-dhcp/pull/132) ([juniorsysadmin](https://github.com/juniorsysadmin))
- parameterize option code 150 [\#130](https://github.com/voxpupuli/puppet-dhcp/pull/130) ([aquister](https://github.com/aquister))
- add parameter list [\#128](https://github.com/voxpupuli/puppet-dhcp/pull/128) ([trevharmon](https://github.com/trevharmon))
- deny dynamic bootp clients if failover is set [\#126](https://github.com/voxpupuli/puppet-dhcp/pull/126) ([aquister](https://github.com/aquister))
- Add missing badges [\#124](https://github.com/voxpupuli/puppet-dhcp/pull/124) ([dhoppe](https://github.com/dhoppe))
- params for update-static-leases and update-optimization [\#123](https://github.com/voxpupuli/puppet-dhcp/pull/123) ([aquister](https://github.com/aquister))
- support for IPv6 pool [\#121](https://github.com/voxpupuli/puppet-dhcp/pull/121) ([aquister](https://github.com/aquister))
- support for IPv6 nameservers [\#120](https://github.com/voxpupuli/puppet-dhcp/pull/120) ([aquister](https://github.com/aquister))
- Document the define in manifests/ignoredsubnet.pp [\#118](https://github.com/voxpupuli/puppet-dhcp/pull/118) ([tobias-urdin](https://github.com/tobias-urdin))
- added dhcpd\_conf\_filename param [\#117](https://github.com/voxpupuli/puppet-dhcp/pull/117) ([aquister](https://github.com/aquister))
- Clarify test names [\#115](https://github.com/voxpupuli/puppet-dhcp/pull/115) ([jskarpe](https://github.com/jskarpe))

## [v1.0.1](https://github.com/voxpupuli/puppet-dhcp/tree/v1.0.1) (2016-09-26)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v1.0.0...v1.0.1)

**Closed issues:**

- All Numeric MAC causes  Detail: undefined method `upcase' [\#109](https://github.com/voxpupuli/puppet-dhcp/issues/109)
- Gap between forge and github version [\#104](https://github.com/voxpupuli/puppet-dhcp/issues/104)
- Add MTU parameter  [\#98](https://github.com/voxpupuli/puppet-dhcp/issues/98)

**Merged pull requests:**

- release: 1.0.1 [\#114](https://github.com/voxpupuli/puppet-dhcp/pull/114) ([daenney](https://github.com/daenney))
- metadata: Concat 2 is backwards compatible with 1 [\#113](https://github.com/voxpupuli/puppet-dhcp/pull/113) ([daenney](https://github.com/daenney))
- Allow for dhcp host to be ignored [\#111](https://github.com/voxpupuli/puppet-dhcp/pull/111) ([charlesdunbar](https://github.com/charlesdunbar))
- Add parameter validation to dhcp::host [\#110](https://github.com/voxpupuli/puppet-dhcp/pull/110) ([alexjfisher](https://github.com/alexjfisher))
- correct misleading documentation for pool ranges [\#107](https://github.com/voxpupuli/puppet-dhcp/pull/107) ([dwerder](https://github.com/dwerder))
- Added ddns-update-style option [\#101](https://github.com/voxpupuli/puppet-dhcp/pull/101) ([jskarpe](https://github.com/jskarpe))
- add mtu option [\#99](https://github.com/voxpupuli/puppet-dhcp/pull/99) ([alvin-huang](https://github.com/alvin-huang))

## [v1.0.0](https://github.com/voxpupuli/puppet-dhcp/tree/v1.0.0) (2016-08-18)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v0.5.0...v1.0.0)

**Closed issues:**

- Parameterise "authoritative" statement [\#87](https://github.com/voxpupuli/puppet-dhcp/issues/87)
- No dependency on Module Concat [\#17](https://github.com/voxpupuli/puppet-dhcp/issues/17)
- Docs: Rdoc for classes and defines [\#13](https://github.com/voxpupuli/puppet-dhcp/issues/13)
- Docs: mention the ripienaar-concat dependency [\#11](https://github.com/voxpupuli/puppet-dhcp/issues/11)

**Merged pull requests:**

- Modulesync 0.12.1 & Release 1.0.0 [\#103](https://github.com/voxpupuli/puppet-dhcp/pull/103) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 0.11.1 [\#102](https://github.com/voxpupuli/puppet-dhcp/pull/102) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 0.8.1 [\#97](https://github.com/voxpupuli/puppet-dhcp/pull/97) ([bbriggs](https://github.com/bbriggs))
- Added option dns search domain [\#96](https://github.com/voxpupuli/puppet-dhcp/pull/96) ([jskarpe](https://github.com/jskarpe))
- Add 'authoritative' parameter [\#95](https://github.com/voxpupuli/puppet-dhcp/pull/95) ([domcleal](https://github.com/domcleal))
- Use ISC default for default\_lease\_time [\#84](https://github.com/voxpupuli/puppet-dhcp/pull/84) ([domcleal](https://github.com/domcleal))
- rubocop: fix Style/StringLiterals [\#83](https://github.com/voxpupuli/puppet-dhcp/pull/83) ([bastelfreak](https://github.com/bastelfreak))
- Add initial Archlinux and LDAP support [\#79](https://github.com/voxpupuli/puppet-dhcp/pull/79) ([bastelfreak](https://github.com/bastelfreak))
- Add optional "comment" field to host template. [\#75](https://github.com/voxpupuli/puppet-dhcp/pull/75) ([simon3270](https://github.com/simon3270))
- Work around notification problem with concat resources [\#71](https://github.com/voxpupuli/puppet-dhcp/pull/71) ([michaelweiser](https://github.com/michaelweiser))

## [v0.5.0](https://github.com/voxpupuli/puppet-dhcp/tree/v0.5.0) (2016-05-22)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/2ff3a2c89aac13d6c73282c044552d11cd81ce25...v0.5.0)

**Breaking changes:**

- Set ddns-hostname instead of option host-name for host declarations [\#59](https://github.com/voxpupuli/puppet-dhcp/pull/59) ([treydock](https://github.com/treydock))

**Implemented enhancements:**

- Add support for iPXE chain loading [\#74](https://github.com/voxpupuli/puppet-dhcp/pull/74) ([mattkirby](https://github.com/mattkirby))

**Closed issues:**

- add unit tests [\#24](https://github.com/voxpupuli/puppet-dhcp/issues/24)
- Tests - Pool has a string not an array [\#18](https://github.com/voxpupuli/puppet-dhcp/issues/18)

**Merged pull requests:**

- Modulesync 0.6.3 + release 0.5.0 [\#81](https://github.com/voxpupuli/puppet-dhcp/pull/81) ([bastelfreak](https://github.com/bastelfreak))
- \[WIP\]modulesync 0.6.1 [\#80](https://github.com/voxpupuli/puppet-dhcp/pull/80) ([bastelfreak](https://github.com/bastelfreak))
- Fix typo in spec test [\#76](https://github.com/voxpupuli/puppet-dhcp/pull/76) ([mattkirby](https://github.com/mattkirby))
- Add the ability to add extra configurations in plain-text [\#73](https://github.com/voxpupuli/puppet-dhcp/pull/73) ([9bryan](https://github.com/9bryan))
- do not sort pool dns servers list [\#72](https://github.com/voxpupuli/puppet-dhcp/pull/72) ([ghost](https://github.com/ghost))
- Release 0.4.0 prep [\#70](https://github.com/voxpupuli/puppet-dhcp/pull/70) ([bmjen](https://github.com/bmjen))
- Enable Ignore unknown clients in templating [\#68](https://github.com/voxpupuli/puppet-dhcp/pull/68) ([prizos](https://github.com/prizos))
- properly put ""quotes around the domain-name option in pool declarations [\#67](https://github.com/voxpupuli/puppet-dhcp/pull/67) ([ghost](https://github.com/ghost))
- Changed dhcpd.conf File dependency to Concat. [\#64](https://github.com/voxpupuli/puppet-dhcp/pull/64) ([chrisdaish](https://github.com/chrisdaish))
- Fix in documentation for dhcp::pool. range should be array instead of string [\#63](https://github.com/voxpupuli/puppet-dhcp/pull/63) ([bjvrielink](https://github.com/bjvrielink))
- Add omapi\_port parameter [\#62](https://github.com/voxpupuli/puppet-dhcp/pull/62) ([treydock](https://github.com/treydock))
- Fix default ntpservers value to not fail validation [\#61](https://github.com/voxpupuli/puppet-dhcp/pull/61) ([treydock](https://github.com/treydock))
- Allow additional options to be specified for dhcp::host [\#60](https://github.com/voxpupuli/puppet-dhcp/pull/60) ([treydock](https://github.com/treydock))
- Add dnskeyname parameter [\#58](https://github.com/voxpupuli/puppet-dhcp/pull/58) ([treydock](https://github.com/treydock))
- Normalise MAC addresses to upper case in dhcpd.host [\#57](https://github.com/voxpupuli/puppet-dhcp/pull/57) ([drt24](https://github.com/drt24))
- Modernize Module [\#56](https://github.com/voxpupuli/puppet-dhcp/pull/56) ([underscorgan](https://github.com/underscorgan))
- Move to use osfamily [\#55](https://github.com/voxpupuli/puppet-dhcp/pull/55) ([sfozz](https://github.com/sfozz))
- Issues/fix rspec [\#50](https://github.com/voxpupuli/puppet-dhcp/pull/50) ([sfozz](https://github.com/sfozz))
- Allow overriding the domain name per pool [\#48](https://github.com/voxpupuli/puppet-dhcp/pull/48) ([ekohl](https://github.com/ekohl))
- Add nameservers and pxeserver parameters to pool [\#47](https://github.com/voxpupuli/puppet-dhcp/pull/47) ([ekohl](https://github.com/ekohl))
- Cleanup 34 [\#46](https://github.com/voxpupuli/puppet-dhcp/pull/46) ([underscorgan](https://github.com/underscorgan))
- Add ignoresubnet class [\#45](https://github.com/voxpupuli/puppet-dhcp/pull/45) ([underscorgan](https://github.com/underscorgan))
- Added globaloptions parameter to dhcp class [\#41](https://github.com/voxpupuli/puppet-dhcp/pull/41) ([dgmorales](https://github.com/dgmorales))
- Corrections and fixes... [\#40](https://github.com/voxpupuli/puppet-dhcp/pull/40) ([pecastro](https://github.com/pecastro))
- Remove trailing whitespace :\( [\#38](https://github.com/voxpupuli/puppet-dhcp/pull/38) ([underscorgan](https://github.com/underscorgan))
- Prep for 0.3.0 release. [\#37](https://github.com/voxpupuli/puppet-dhcp/pull/37) ([underscorgan](https://github.com/underscorgan))
- Add patches from foreman-dhcp [\#36](https://github.com/voxpupuli/puppet-dhcp/pull/36) ([ekohl](https://github.com/ekohl))
- Remove deprecation warnings for templates and use of concat::setup [\#32](https://github.com/voxpupuli/puppet-dhcp/pull/32) ([kscherer](https://github.com/kscherer))
- Correct concat dependency [\#30](https://github.com/voxpupuli/puppet-dhcp/pull/30) ([hunner](https://github.com/hunner))
- Concat update [\#28](https://github.com/voxpupuli/puppet-dhcp/pull/28) ([jhoblitt](https://github.com/jhoblitt))
- Add apache 2.0 license. [\#26](https://github.com/voxpupuli/puppet-dhcp/pull/26) ([apenney](https://github.com/apenney))
- addition of some simple unit tests for issue 24 [\#25](https://github.com/voxpupuli/puppet-dhcp/pull/25) ([wolfspyre](https://github.com/wolfspyre))
- Make 'range' optional [\#21](https://github.com/voxpupuli/puppet-dhcp/pull/21) ([faja](https://github.com/faja))
- Define class without ntpservers-parameter. [\#19](https://github.com/voxpupuli/puppet-dhcp/pull/19) ([ahaitoute](https://github.com/ahaitoute))
- Remove failover parameter from class dhcp [\#14](https://github.com/voxpupuli/puppet-dhcp/pull/14) ([saz](https://github.com/saz))
- Added Redhat/CentOS package name [\#12](https://github.com/voxpupuli/puppet-dhcp/pull/12) ([crayfishx](https://github.com/crayfishx))
- Whitespace only removal of comments [\#10](https://github.com/voxpupuli/puppet-dhcp/pull/10) ([jeffmccune](https://github.com/jeffmccune))
- Send the client hostname to be used if unset [\#9](https://github.com/voxpupuli/puppet-dhcp/pull/9) ([jeffmccune](https://github.com/jeffmccune))
- Make the dhcp module more reusable [\#8](https://github.com/voxpupuli/puppet-dhcp/pull/8) ([jeffmccune](https://github.com/jeffmccune))
- Make all template fragments have header comments [\#7](https://github.com/voxpupuli/puppet-dhcp/pull/7) ([jeffmccune](https://github.com/jeffmccune))
- Update dhcp module path for Ubuntu precise. [\#6](https://github.com/voxpupuli/puppet-dhcp/pull/6) ([nanliu](https://github.com/nanliu))
- Fix modulefile for puppetlabs. [\#5](https://github.com/voxpupuli/puppet-dhcp/pull/5) ([nanliu](https://github.com/nanliu))
- Update manifests per puppet-lint [\#4](https://github.com/voxpupuli/puppet-dhcp/pull/4) ([nanliu](https://github.com/nanliu))
- Module puppet-lint clean up. [\#3](https://github.com/voxpupuli/puppet-dhcp/pull/3) ([nanliu](https://github.com/nanliu))
- Fix typo in dhcpd.conf.ddns.erb [\#1](https://github.com/voxpupuli/puppet-dhcp/pull/1) ([jeffmccune](https://github.com/jeffmccune))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
