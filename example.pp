node default {
  class { 'workstation':
    username => 'lognoz',
    password => 'default',
    timezone => 'Canada/Eastern'
  }

  include workstation::sudo
  include workstation::system
  include workstation::package
  include workstation::x11::xorg

  workstation::x11::conf { [
    'setxkbmap -option caps:escape &',
    'xrandr --output DVI-I-1 --right-of HDMI-0 &'
  ]: }

  class { 'workstation::languages':
    keyboard => 'us,ca',
    aspell => ['en','fr']
  }

  class { 'workstation::graphic':
    hardware => 'nvidia'
  }

  class { 'workstation::user::git':
    username  => 'Marc-Antoine Loignon',
    email => 'developer@lognoz.org'
  }

  include workstation::x11::dwm
  include workstation::user::directories

  class { 'workstation::user::vim':
    source => 'https://github.com/lognoz/vimrc'
  }

  include workstation::web::php
  include workstation::web::mysql
  include workstation::web::apache
  include workstation::web::npm
}
