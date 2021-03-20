node default {
  Exec {
    path => [
      '/bin/',
      '/sbin/',
      '/usr/bin/',
      '/usr/sbin/',
      '/usr/local/bin/'
    ]
  }

  class { 'workstation':
    username => 'lognoz',
    password => 'default',
    timezone => 'America/New_York'
  }

  class { 'workstation::graphic':
    hardware => 'nvidia'
  }

  class { 'workstation::keyboard':
    keyboard => 'us,ca'
  }

  class { 'workstation::language':
    aspell => [ 'en','fr' ]
  }

  class { 'workstation::user::git':
    username  => 'Marc-Antoine Loignon',
    email => 'developer@lognoz.org'
  }

  class { 'workstation::user::vim':
    source => 'https://github.com/lognoz/vimrc'
  }

  class { 'workstation::user::emacs':
    source => 'https://github.com/lognoz/embla'
  }

  class { 'workstation::user::directories':
    download => '/download/browser',
    directories => [
      '/download',
      '/download/browser',
      '/download/torrent',
      '/download/wget',
      '/document',
      '/document/org',
      '/music',
      '/program',
      '/video',
      '/video/youtube'
    ]
  }

  workstation::bash::rc { [
    'PS1="\W \$ "',
    'alias ls="ls -F"',
    'alias ll="ls -lah"'
  ]: }

  class { 'workstation::multimedia::wget':
    directory => 'download/wget'
  }

  class { 'workstation::multimedia::torrent':
    directory => 'download/torrent'
  }

  class { 'workstation::multimedia::youtube_dl':
    directory => 'video/youtube'
  }

  class { 'workstation::multimedia::firefox':
    extensions => [
      '3679754/ublock_origin-1.31.0-an+fx.xpi',
      '3679479/https_everywhere-2020.11.17-an+fx.xpi',
      '3690660/user_agent_switcher-1.4.1-an+fx.xpi',
      '3672658/decentraleyes-2.0.15-an+fx.xpi',
      '3682334/clearurls-1.20.0-an+fx.xpi',
      '3691752/noscript_security_suite-11.1.6-an+fx.xpi',
      '3724574/grammatik_und_rechtschreibprufung_languagetool-3.3.4-fx.xpi'
    ]
  }

  workstation::x11::conf { [
    'xrandr --output DVI-I-1 --right-of HDMI-0 --primary &'
  ]: }

  include workstation::gnu
  include workstation::doas
  include workstation::sudo
  include workstation::system
  include workstation::package
  include workstation::alsamixer
  include workstation::x11::dwm

  include workstation::programming::python
  include workstation::programming::virtualisation
  include workstation::programming::lisp::clisp

  include workstation::programming::web::php
  include workstation::programming::web::mysql
  include workstation::programming::web::apache
  include workstation::programming::web::npm

  include workstation::multimedia::wget
  include workstation::multimedia::firefox
  include workstation::multimedia::torrent
}
