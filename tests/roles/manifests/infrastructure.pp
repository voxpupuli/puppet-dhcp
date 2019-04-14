# Role to manage dns, dhcp, pxe and bind
class role::infrastructure () {

  include profile::base
  include profile::dhcp

}
