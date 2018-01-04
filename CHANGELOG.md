# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v3.2.0](https://github.com/voxpupuli/puppet-dhcp/tree/v3.2.0) (2018-01-04)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v3.1.0...v3.2.0)

**Implemented enhancements:**

- add ddns\_client\_updates parameter [\#172](https://github.com/voxpupuli/puppet-dhcp/pull/172) ([tiernap](https://github.com/tiernap))

**Closed issues:**

- Could not find dependent Service\[dhcpd\] for File\[/etc/systemd/system/dhcpd.service\] when manage\_service is false [\#170](https://github.com/voxpupuli/puppet-dhcp/issues/170)

**Merged pull requests:**

- Use match\_array for better failure output [\#173](https://github.com/voxpupuli/puppet-dhcp/pull/173) ([ekohl](https://github.com/ekohl))
- Fix notification target [\#171](https://github.com/voxpupuli/puppet-dhcp/pull/171) ([danyel2014](https://github.com/danyel2014))
- release 3.1.0 [\#168](https://github.com/voxpupuli/puppet-dhcp/pull/168) ([bastelfreak](https://github.com/bastelfreak))

## [v3.1.0](https://github.com/voxpupuli/puppet-dhcp/tree/v3.1.0) (2017-11-11)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v3.0.0...v3.1.0)

**Merged pull requests:**

- dhcpd.conf-extra: move includes below extra\_config [\#166](https://github.com/voxpupuli/puppet-dhcp/pull/166) ([aquister](https://github.com/aquister))
- dhcp::failover parameter scope fix [\#165](https://github.com/voxpupuli/puppet-dhcp/pull/165) ([aquister](https://github.com/aquister))
- parameterised ddns-hostnames [\#164](https://github.com/voxpupuli/puppet-dhcp/pull/164) ([tiernap](https://github.com/tiernap))
- Use dhcpd\_conf\_filename param [\#163](https://github.com/voxpupuli/puppet-dhcp/pull/163) ([aquister](https://github.com/aquister))
- Release 3.0.0 [\#162](https://github.com/voxpupuli/puppet-dhcp/pull/162) ([bastelfreak](https://github.com/bastelfreak))

## [v3.0.0](https://github.com/voxpupuli/puppet-dhcp/tree/v3.0.0) (2017-10-18)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v2.1.0...v3.0.0)

**Breaking changes:**

- Write a systemd service file when using systemd [\#154](https://github.com/voxpupuli/puppet-dhcp/pull/154) ([petems](https://github.com/petems))

**Implemented enhancements:**

- use parameter for dhcpd binary path in unit file [\#161](https://github.com/voxpupuli/puppet-dhcp/pull/161) ([bastelfreak](https://github.com/bastelfreak))
- Replace legacy facts with facts hash [\#160](https://github.com/voxpupuli/puppet-dhcp/pull/160) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- release 2.1.0 [\#159](https://github.com/voxpupuli/puppet-dhcp/pull/159) ([bastelfreak](https://github.com/bastelfreak))

## [v2.1.0](https://github.com/voxpupuli/puppet-dhcp/tree/v2.1.0) (2017-09-27)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/v2.0.0...v2.1.0)

**Implemented enhancements:**

- Update $extra\_config to work with arrays and not only strings [\#156](https://github.com/voxpupuli/puppet-dhcp/pull/156) ([bastelfreak](https://github.com/bastelfreak))
- Support SmartOS [\#155](https://github.com/voxpupuli/puppet-dhcp/pull/155) ([petems](https://github.com/petems))

**Merged pull requests:**

- Add breaking changes section to the changelog [\#153](https://github.com/voxpupuli/puppet-dhcp/pull/153) ([bastelfreak](https://github.com/bastelfreak))
- release 2.0.0 [\#152](https://github.com/voxpupuli/puppet-dhcp/pull/152) ([bastelfreak](https://github.com/bastelfreak))

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
- Clarify test names [\#115](https://github.com/voxpupuli/puppet-dhcp/pull/115) ([Yuav](https://github.com/Yuav))

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
- Added ddns-update-style option [\#101](https://github.com/voxpupuli/puppet-dhcp/pull/101) ([Yuav](https://github.com/Yuav))
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
- Added option dns search domain [\#96](https://github.com/voxpupuli/puppet-dhcp/pull/96) ([Yuav](https://github.com/Yuav))
- Add 'authoritative' parameter [\#95](https://github.com/voxpupuli/puppet-dhcp/pull/95) ([domcleal](https://github.com/domcleal))
- Use ISC default for default\_lease\_time [\#84](https://github.com/voxpupuli/puppet-dhcp/pull/84) ([domcleal](https://github.com/domcleal))
- rubocop: fix Style/StringLiterals [\#83](https://github.com/voxpupuli/puppet-dhcp/pull/83) ([bastelfreak](https://github.com/bastelfreak))
- Add initial Archlinux and LDAP support [\#79](https://github.com/voxpupuli/puppet-dhcp/pull/79) ([bastelfreak](https://github.com/bastelfreak))
- Add optional "comment" field to host template. [\#75](https://github.com/voxpupuli/puppet-dhcp/pull/75) ([simon3270](https://github.com/simon3270))
- Work around notification problem with concat resources [\#71](https://github.com/voxpupuli/puppet-dhcp/pull/71) ([michaelweiser](https://github.com/michaelweiser))

## [v0.5.0](https://github.com/voxpupuli/puppet-dhcp/tree/v0.5.0) (2016-05-22)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/2.3.0...v0.5.0)

**Closed issues:**

- Tests - Pool has a string not an array [\#18](https://github.com/voxpupuli/puppet-dhcp/issues/18)

**Merged pull requests:**

- Modulesync 0.6.3 + release 0.5.0 [\#81](https://github.com/voxpupuli/puppet-dhcp/pull/81) ([bastelfreak](https://github.com/bastelfreak))
- \[WIP\]modulesync 0.6.1 [\#80](https://github.com/voxpupuli/puppet-dhcp/pull/80) ([bastelfreak](https://github.com/bastelfreak))

## [2.3.0](https://github.com/voxpupuli/puppet-dhcp/tree/2.3.0) (2016-02-18)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/2.2.0...2.3.0)

**Implemented enhancements:**

- Add support for iPXE chain loading [\#74](https://github.com/voxpupuli/puppet-dhcp/pull/74) ([mattkirby](https://github.com/mattkirby))

**Merged pull requests:**

- Fix typo in spec test [\#76](https://github.com/voxpupuli/puppet-dhcp/pull/76) ([mattkirby](https://github.com/mattkirby))
- Add the ability to add extra configurations in plain-text [\#73](https://github.com/voxpupuli/puppet-dhcp/pull/73) ([9bryan](https://github.com/9bryan))

## [2.2.0](https://github.com/voxpupuli/puppet-dhcp/tree/2.2.0) (2015-10-14)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/2.1.0...2.2.0)

**Merged pull requests:**

- do not sort pool dns servers list [\#72](https://github.com/voxpupuli/puppet-dhcp/pull/72) ([jearls](https://github.com/jearls))

## [2.1.0](https://github.com/voxpupuli/puppet-dhcp/tree/2.1.0) (2015-09-21)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/0.4.0...2.1.0)

## [0.4.0](https://github.com/voxpupuli/puppet-dhcp/tree/0.4.0) (2015-09-15)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/2.0.0...0.4.0)

**Merged pull requests:**

- Release 0.4.0 prep [\#70](https://github.com/voxpupuli/puppet-dhcp/pull/70) ([bmjen](https://github.com/bmjen))
- Enable Ignore unknown clients in templating [\#68](https://github.com/voxpupuli/puppet-dhcp/pull/68) ([prizos](https://github.com/prizos))
- properly put ""quotes around the domain-name option in pool declarations [\#67](https://github.com/voxpupuli/puppet-dhcp/pull/67) ([jearls](https://github.com/jearls))
- Changed dhcpd.conf File dependency to Concat. [\#64](https://github.com/voxpupuli/puppet-dhcp/pull/64) ([chrisdaish](https://github.com/chrisdaish))
- Add omapi\_port parameter [\#62](https://github.com/voxpupuli/puppet-dhcp/pull/62) ([treydock](https://github.com/treydock))

## [2.0.0](https://github.com/voxpupuli/puppet-dhcp/tree/2.0.0) (2015-06-29)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/1.6.0...2.0.0)

**Breaking changes:**

- Set ddns-hostname instead of option host-name for host declarations [\#59](https://github.com/voxpupuli/puppet-dhcp/pull/59) ([treydock](https://github.com/treydock))

**Merged pull requests:**

- Fix in documentation for dhcp::pool. range should be array instead of string [\#63](https://github.com/voxpupuli/puppet-dhcp/pull/63) ([bjvrielink](https://github.com/bjvrielink))
- Fix default ntpservers value to not fail validation [\#61](https://github.com/voxpupuli/puppet-dhcp/pull/61) ([treydock](https://github.com/treydock))
- Allow additional options to be specified for dhcp::host [\#60](https://github.com/voxpupuli/puppet-dhcp/pull/60) ([treydock](https://github.com/treydock))
- Add dnskeyname parameter [\#58](https://github.com/voxpupuli/puppet-dhcp/pull/58) ([treydock](https://github.com/treydock))
- Normalise MAC addresses to upper case in dhcpd.host [\#57](https://github.com/voxpupuli/puppet-dhcp/pull/57) ([drt24](https://github.com/drt24))
- Added globaloptions parameter to dhcp class [\#41](https://github.com/voxpupuli/puppet-dhcp/pull/41) ([dgmorales](https://github.com/dgmorales))

## [1.6.0](https://github.com/voxpupuli/puppet-dhcp/tree/1.6.0) (2015-03-05)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/1.5.0...1.6.0)

**Merged pull requests:**

- Modernize Module [\#56](https://github.com/voxpupuli/puppet-dhcp/pull/56) ([underscorgan](https://github.com/underscorgan))
- Move to use osfamily [\#55](https://github.com/voxpupuli/puppet-dhcp/pull/55) ([sfozz](https://github.com/sfozz))
- Issues/fix rspec [\#50](https://github.com/voxpupuli/puppet-dhcp/pull/50) ([sfozz](https://github.com/sfozz))
- Allow overriding the domain name per pool [\#48](https://github.com/voxpupuli/puppet-dhcp/pull/48) ([ekohl](https://github.com/ekohl))
- Add nameservers and pxeserver parameters to pool [\#47](https://github.com/voxpupuli/puppet-dhcp/pull/47) ([ekohl](https://github.com/ekohl))
- Cleanup 34 [\#46](https://github.com/voxpupuli/puppet-dhcp/pull/46) ([underscorgan](https://github.com/underscorgan))
- Add ignoresubnet class [\#45](https://github.com/voxpupuli/puppet-dhcp/pull/45) ([underscorgan](https://github.com/underscorgan))

## [1.5.0](https://github.com/voxpupuli/puppet-dhcp/tree/1.5.0) (2015-01-28)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/1.4.0...1.5.0)

**Merged pull requests:**

- Corrections and fixes... [\#40](https://github.com/voxpupuli/puppet-dhcp/pull/40) ([pecastro](https://github.com/pecastro))

## [1.4.0](https://github.com/voxpupuli/puppet-dhcp/tree/1.4.0) (2014-08-11)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/0.3.0...1.4.0)

## [0.3.0](https://github.com/voxpupuli/puppet-dhcp/tree/0.3.0) (2014-07-23)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/0.2.0...0.3.0)

**Merged pull requests:**

- Remove trailing whitespace :\( [\#38](https://github.com/voxpupuli/puppet-dhcp/pull/38) ([underscorgan](https://github.com/underscorgan))
- Prep for 0.3.0 release. [\#37](https://github.com/voxpupuli/puppet-dhcp/pull/37) ([underscorgan](https://github.com/underscorgan))
- Add patches from foreman-dhcp [\#36](https://github.com/voxpupuli/puppet-dhcp/pull/36) ([ekohl](https://github.com/ekohl))
- Remove deprecation warnings for templates and use of concat::setup [\#32](https://github.com/voxpupuli/puppet-dhcp/pull/32) ([kscherer](https://github.com/kscherer))

## [0.2.0](https://github.com/voxpupuli/puppet-dhcp/tree/0.2.0) (2014-03-25)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/1.3.1...0.2.0)

**Merged pull requests:**

- Release 0.2.0 [\#31](https://github.com/voxpupuli/puppet-dhcp/pull/31) ([hunner](https://github.com/hunner))
- Correct concat dependency [\#30](https://github.com/voxpupuli/puppet-dhcp/pull/30) ([hunner](https://github.com/hunner))
- Concat update [\#28](https://github.com/voxpupuli/puppet-dhcp/pull/28) ([jhoblitt](https://github.com/jhoblitt))
- Make 'range' optional [\#21](https://github.com/voxpupuli/puppet-dhcp/pull/21) ([faja](https://github.com/faja))
- Define class without ntpservers-parameter. [\#19](https://github.com/voxpupuli/puppet-dhcp/pull/19) ([ahaitoute](https://github.com/ahaitoute))
- Remove failover parameter from class dhcp [\#14](https://github.com/voxpupuli/puppet-dhcp/pull/14) ([saz](https://github.com/saz))

## [1.3.1](https://github.com/voxpupuli/puppet-dhcp/tree/1.3.1) (2014-01-20)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/0.1.0...1.3.1)

**Closed issues:**

- add unit tests [\#24](https://github.com/voxpupuli/puppet-dhcp/issues/24)

**Merged pull requests:**

- Add apache 2.0 license. [\#26](https://github.com/voxpupuli/puppet-dhcp/pull/26) ([apenney](https://github.com/apenney))
- addition of some simple unit tests for issue 24 [\#25](https://github.com/voxpupuli/puppet-dhcp/pull/25) ([wolfspyre](https://github.com/wolfspyre))
- Added Redhat/CentOS package name [\#12](https://github.com/voxpupuli/puppet-dhcp/pull/12) ([crayfishx](https://github.com/crayfishx))
- Whitespace only removal of comments [\#10](https://github.com/voxpupuli/puppet-dhcp/pull/10) ([jeffmccune](https://github.com/jeffmccune))

## [0.1.0](https://github.com/voxpupuli/puppet-dhcp/tree/0.1.0) (2012-06-11)

[Full Changelog](https://github.com/voxpupuli/puppet-dhcp/compare/2ff3a2c89aac13d6c73282c044552d11cd81ce25...0.1.0)

**Merged pull requests:**

- Send the client hostname to be used if unset [\#9](https://github.com/voxpupuli/puppet-dhcp/pull/9) ([jeffmccune](https://github.com/jeffmccune))
- Make the dhcp module more reusable [\#8](https://github.com/voxpupuli/puppet-dhcp/pull/8) ([jeffmccune](https://github.com/jeffmccune))
- Make all template fragments have header comments [\#7](https://github.com/voxpupuli/puppet-dhcp/pull/7) ([jeffmccune](https://github.com/jeffmccune))
- Update dhcp module path for Ubuntu precise. [\#6](https://github.com/voxpupuli/puppet-dhcp/pull/6) ([nanliu](https://github.com/nanliu))
- Fix modulefile for puppetlabs. [\#5](https://github.com/voxpupuli/puppet-dhcp/pull/5) ([nanliu](https://github.com/nanliu))
- Update manifests per puppet-lint [\#4](https://github.com/voxpupuli/puppet-dhcp/pull/4) ([nanliu](https://github.com/nanliu))
- Module puppet-lint clean up. [\#3](https://github.com/voxpupuli/puppet-dhcp/pull/3) ([nanliu](https://github.com/nanliu))
- Fix typo in dhcpd.conf.ddns.erb [\#1](https://github.com/voxpupuli/puppet-dhcp/pull/1) ([jeffmccune](https://github.com/jeffmccune))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*