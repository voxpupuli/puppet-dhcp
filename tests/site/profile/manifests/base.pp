# Thanks Puppet
class profile::base {
  #class { '::ntp': }
  notify { 'Inside the base class' : }

  file { '/tmp/nmm.junk' :
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
  }
}
