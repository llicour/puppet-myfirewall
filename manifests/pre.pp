# Default pre rules
# Apply this by default before anything else

class myfirewall::pre {
  Firewall { require => undef, }

  # Default firewall rules
  firewall { '000 accept all icmp' :
    proto   => 'icmp',
    action  => 'accept',
  }->
  firewall { '001 accept all to lo interface' :
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 accept related established rules' :
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    action  => 'accept',
  }->
  firewall { '003 accept SSH' :
    chain  => 'INPUT',
    proto  => 'tcp',
    state  => 'NEW',
    dport  => '22',
    action => 'accept',
  }
}

