# Class: workstation::user::directories
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::user::directories
#
class workstation::user::directories (
  String $desktop  = '/',
  String $document = '/document',
  String $download = '/download',
  String $music    = '/music',
  String $picture  = '/picture',
  String $public   = '/public',
  String $template = '/template',
  String $video    = '/video',
  Array $directories = []
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { 'xdg-user-dirs': }

  File {
    owner => $workstation::username,
    group => $workstation::username,
    mode  => '0755'
  }

  file { "/home/${workstation::username}/.config":
    ensure => directory
  }

  file { "/home/${workstation::username}/.config/user-dirs.dirs":
    ensure  => present,
    content => template('workstation/user-dirs.erb')
  }

  $directories.each |String $directory| {
    file { "/home/${workstation::username}/${directory}":
      ensure => directory
    }
  }
}
