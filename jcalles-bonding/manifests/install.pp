class bonding::install($st) {
    case $::operatingsystem {
      /^(Debian|Ubuntu)$/ : { 

  package {'ifenslave-2.6': 
      ensure => installed
          } 

  augeas{ "bond_interface" :
    context => "/files/etc/network/interfaces",
    changes => [
        "set auto[child::1 = '${::bond}']/1 ${::bond}",
        "set iface[. = '${::bond}'] ${::bond}",
        "set iface[. = '${::bond}']/family inet",
        "set iface[. = '${::bond}']/method static",
        "set iface[. = '${::bond}']/address ${::ip_address}",
        "set iface[. = '${::bond}']/netmask ${::netmask}",
        "set iface[. = '${::bond}']/gateway ${::gateway}",
        "set iface[. = '${::bond}']/slaves '${::slaves}'",
              ],
}
  file {
  "${::bond}_deb":
  path    => '/etc/modprobe.d/bonding.conf',
  content => template('bonding/bonding.conf.erb'),
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  require => Augeas['bond_interface'],
  notify => Service['network'],
} # end file



}
                 default  : { notice("Not support ${::operatingsystem}") }
                            }
}
