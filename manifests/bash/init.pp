# Class: workstation::bash::init
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::bash::init
#
class workstation::bash::init {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation

  file { "/home/${workstation::username}/.bashrc":
    ensure => present,
    owner  => $workstation::username,
    group  => $workstation::username,
    mode   => '0755'
  }
}
