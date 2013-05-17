# Needs the module 'puppetlabs-firewall'

class myfirewall {

    #$ipv4_file = $::osfamily ? {
    #    'Debian' => '/etc/iptables/rules.v4',
    #    default  => '/etc/sysconfig/iptables',
    #}

    #exec { 'purge-default-firewall' :
    #    command =>
    #      "/sbin/iptables -F && /sbin/iptables-save > ${ipv4_file} && /sbin/service iptables restart",
    #    onlyif  =>
    #      "/bin/grep -q \"Firewall configuration written by\" ${ipv4_file}",
    #    user    => 'root',
    #}

  ## prevent shutdown hanging at "iptables unloading modules"
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
  
  #class { 'firewall': }

}

