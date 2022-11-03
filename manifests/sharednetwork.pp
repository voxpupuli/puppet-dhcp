# @summary
#   defines a sharednetwork-segment to wrap several pools together
#
# @param sharednetwork
#   Name of the sharednetwork as used in `dhcp::pool` and `dhcp::pool6`
#   defaults to the title of this resource
#
# @param parameters
#   optional defaults you can set for the shared-network
#   can be either a single parameter-string, or an array of
#   several parameters
define dhcp::sharednetwork (
  String $sharednetwork = $title,
  Optional[Variant[Array[String[1]], String[1]]] $parameters = undef,
) {
  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment {
    "dhcp_sharednetwork_${name}_head":
      target  => "${dhcp_dir}/dhcpd.pools",
      content => template('dhcp/dhcpd.sharednetwork.erb'),
      order   => "10 ${sharednetwork}-09";

    "dhcp_sharednetwork_${name}_foot":
      target  => "${dhcp_dir}/dhcpd.pools",
      content => "}\n",
      order   => "10 ${sharednetwork}-11";
  }
}
