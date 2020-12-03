node default {
  class { 'workstation':
    username => 'lognoz',
    password => 'default',
    timezone => 'Canada/Eastern'
  }
}
