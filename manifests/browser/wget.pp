# Class: workstation::browser::wget
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::browser::wget
#
class workstation::browser::wget {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  class { 'wget':
    package_manage => true,
    package_ensure => present,
    package_name   => 'wget',
  }
}
