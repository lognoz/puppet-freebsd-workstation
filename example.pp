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

  class { 'workstation::user::vim':
    source => 'https://github.com/lognoz/vimrc'
  }

  include workstation::x11::dwm
  include workstation::user::directories

  include workstation::programming::web::php
  include workstation::programming::web::mysql
  include workstation::programming::web::apache
  include workstation::programming::web::npm

  include workstation::programming::python
  include workstation::programming::virtualisation

  include workstation::browser::wget
  include workstation::browser::firefox
}
