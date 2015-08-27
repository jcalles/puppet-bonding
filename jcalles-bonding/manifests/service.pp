class bonding::service{
  service {
  'network':
  ensure      => running,
  hasrestart  => true,
  hasstatus   => true,
  enable      => true,
}
}
