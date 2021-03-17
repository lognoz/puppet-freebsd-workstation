# Class: workstation::doas
#
# This class sets doas package. This program allows a regular user to
# run commands as another user (usually root).
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::doas
#
class workstation::doas {
  # Make sure this subclasses is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
    $username = $workstation::username
  }

  package { 'doas': }

  file { '/usr/local/etc/doas.conf':
    ensure  => present,
    content => template('workstation/doas.erb')
  }
}
