# ----------
# Debian specific configuration items.
# ----------
class dhcp::debian {
  include dhcp::params

  case $operatingsystem {
    'debian','ubuntu': {
      file{ '/etc/default/isc-dhcp-server':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        before  => Package[$packagename],
        notify  => Service[$servicename],
        content => template('dhcp/debian/default_isc-dhcp-server'),
      }
    }
  }
}
