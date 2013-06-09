# Needs the module 'puppetlabs-firewall'

class myfirewall {

  # prevent shutdown hanging at "iptables unloading modules"
  file { '/etc/sysconfig/iptables-config' :
      ensure => present,
      source => 'puppet:///modules/myfirewall/iptables-config',
      owner  => 'root',
      group  => 'root',
      mode   => '0600',
  }

  resources { 'firewall': purge => true }

  Firewall {
        before  => Class[ 'myfirewall::post' ],
        require => Class[ 'myfirewall::pre' ],
  }

  class { ['myfirewall::pre', 'myfirewall::post']: }

  include firewall

}

