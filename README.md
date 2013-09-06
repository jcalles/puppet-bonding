==bonding module.

License
-------
Apache License, Version 2.0

Contact
-------
javier.calles@smartmatic.com

Support
-------
https://groups.google.com/forum/#!forum/puppet-venezuela
Please log tickets and issues at our [Projects site](http://https://groups.google.com/forum/#!forum/puppet-venezuela)

 == Class: bonding

 Manages and configures the bonding between two network ports on two different cards
 	
 	NIC ONE				NIC TWO
 	---------------------------------    -----------------------------  
 	|  eth0	| eth1	| eth2	| eth3	|    | eth4 | eth5 | eth6 | eth7 |
 	|	|	|	|	|    |      |      |      |	 |
 	---------------------------------    -----------------------------
           ^					^
           |					|
           -------------------------------------

 === Variables

 Here you should define a list of variables that this module would require.


  dns       =>    #namserver
  bond      =>    #bonding interface
  mode      =>    #balance-rr=0,active-backup =1,balance-xor=2
  		  #broadcast=3,802.3ad=4,balance-tlb=5,balance-alb=6 
  netmask   =>    #Network mask 
  lacp_rate =>    #slow or 0 — Default setting. This specifies that partners 
                  #should transmit LACPDUs every 30 seconds.
                  #fast or 1 — Specifies that partners should transmit LACPDUs every 1 second. 
  miimon    =>    #Specifies (in milliseconds) how often MII link monitoring occurs
  domain    =>    #Domain 


 === Examples
  	node 'fqdn'  {
   	class {'bonding': stage => 'post'}  # Previamente definido en el site.pp sino, solo "include bonding"
  		bonding::config{'bonding':
  			dns       => '10.10.10.11',  
  			bond      => 'bond0',         
  			mode      => '4',             
  			netmask   => '255.255.255.0',
  			lacp_rate => '1',             
  			miimon    => '100',          
  			domain    => 'mydomain.com', 

  		 }	


 === Authors

 Javier Calles  <javier.calles@smartmatic.com>

 === Copyright

 Copyright 2013 Javier Calles
