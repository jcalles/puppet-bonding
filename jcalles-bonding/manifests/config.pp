define  bonding::config($bond,
                          $mode,
                          $netmask,
                          $lacp_rate,
                          $miimon,
                          $dns,
                          $domain)
{
case $::operatingsystem {
  /(Debian|Ubuntu)/: {fail("not implemented yet")}
  /(CentOS|RedHat)/: {

  file {
  'ifcfg-eth0':
  path    => '/etc/sysconfig/network-scripts/ifcfg-eth0',
  content => template('bonding/ifcfg-eth0.erb'),
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
  file {
  'ifcfg-eth4':
  path    => '/etc/sysconfig/network-scripts/ifcfg-eth4',
  content => template('bonding/ifcfg-eth4.erb'),
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}

  file {"ifcfg-${bond}":
  path    => "/etc/sysconfig/network-scripts/ifcfg-${bond}",
  content => template('bonding/ifcfg-bondx.erb'),
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  require => File['ifcfg-eth0','ifcfg-eth4'],
  notify  => Service['network'],
}

if ($::operatingsystemrelease == '5.8') {

  file_line{
  "${bond}_modprobe_5.8":
  path => '/etc/modprobe.conf',
  line => "options ${bond} miimon=${miimon} mode=${mode} lacp_rate=${lacp_rate}";
}
  file_line{
  "${bond}_alias_5.8":
  path => '/etc/modprobe.conf',
  line => "alias ${bond} bonding";
}
}
###### bonding para release 6.0 o 6.4
else {

  file {
  "${bond}_6X":
  path    => '/etc/modprobe.d/bonding.conf',
  content => template('bonding/bonding.conf.erb'),
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  require => File['ifcfg-eth0','ifcfg-eth4'],
} # end file
} # end else
} # end selector
      default: { fail("Not Implemented yet") }
} # end case
} # end define
