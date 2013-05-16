# Default post rules
# Drop everything eventually

class myfirewall::post {
  firewall { '999 drop all on FORWARD eventually' :
      chain   => 'FORWARD',
      proto   => 'all',
      action  => 'drop',
      before  => undef,
  }
  firewall { '999 drop all on INPUT eventually' :
      chain  => 'INPUT',
      proto  => 'all',
      action => 'drop',
      before => undef,
  }
}

