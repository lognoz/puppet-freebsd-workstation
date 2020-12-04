node default {
  class { 'workstation':
    username => 'lognoz',
    password => 'default',
    timezone => 'Canada/Eastern'
  }

  class { 'workstation::graphic':
    hardware => 'nvidia'
  }

  class { 'workstation::git':
    username  => 'Marc-Antoine Loignon',
    email => 'developer@lognoz.org'
  }

  include workstation::sudo
  include workstation::system
  include workstation::package
  include workstation::xorg

  class { 'workstation::languages':
    keyboard => 'us,ca',
    aspell => ['en','fr']
  }
}
