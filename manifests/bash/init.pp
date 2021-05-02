# Class: workstation::bash::init
#
# This class install bash and some useful configurations.
#
# Variables:
#   `files` — Type: *array* — Default: *[]*
#   List of files related to bash that need to be created.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::bash::init
#
class workstation::bash::init (
  Array $files = [
    '.bashrc',
    '.aliases'
  ]
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation

  exec { 'Change permanently the default shell':
    command => 'chsh -s /usr/local/bin/bash'
  }

  $files.each |String $filename| {
    file { "/home/${workstation::username}/${filename}":
      ensure => present,
      owner => $workstation::username,
      group => $workstation::username,
      mode  => '0755'
    }
  }

  workstation::bash::rc {
    '[ -r ~/.aliases ] && [ -f ~/.aliases ] && source ~/.aliases':
  }
}
