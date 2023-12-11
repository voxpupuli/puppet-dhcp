# @summary Manage a DHCP host
#
# @param ip
#    The ip address of the DHCP host.
#
# @param mac
#    The MAC address.
#
# @param ddns_hostname
#    The name parameter should be the hostname that will be used in setting up the client's A and PTR records. 
#    If no ddns-hostname is specified in scope, then the server will derive the hostname automatically, using an 
#    algorithm that varies for each of the different update methods.
#
# @param options
#    A hash with key value pairs to go to the option lines. The word 'option' is not needed.
#
# @param comment
#    A comment added to the DHCP host.
#
# @param ignored
#    If set to true results in `ignore booting;` line in the DHCP host configuration.
#
# @param default_lease_time
#    Default lease length.
#
# @param max_lease_time
#    The maximum lease length.
#
# @param ipxe_filename
#    The ipxe filenme, e. g. ipxe.efi.
#
# @param ipxe_bootstrap
#    The bootstrap file of UEFI PXE, e. g. winpe.ipxe
#
# @param filename
#    The file to be loaded by TFTP.
#
# @param on_commit
#    An array with statements to go into the hook on commit.
#
# @param on_release
#    An array with statements to go into the hook on release.
#
# @param on_expiry
#    An array with statements to go into the hook on expiry.
define dhcp::host (
  Dhcp::Mac $mac,
  Optional[Stdlib::IP::Address] $ip     = undef,
  String $ddns_hostname                 = $name,
  Hash $options                         = {},
  Optional[String[1]] $comment          = undef,
  Boolean $ignored                      = false,
  Optional[Integer] $default_lease_time = undef,
  Optional[Integer] $max_lease_time     = undef,
  Optional[String[1]] $ipxe_filename    = undef,
  Optional[String[1]] $ipxe_bootstrap   = undef,
  Optional[String[1]] $filename         = undef,
  Array[String[1]] $on_commit           = [],
  Array[String[1]] $on_release          = [],
  Array[String[1]] $on_expiry           = [],
) {
  $host = $name

  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_host_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.host.erb'),
    order   => '10',
  }
}
