# Thanks Puppet
class profile::base {
  #class { '::ntp': }
  notify { 'Inside the base class' : }

}
