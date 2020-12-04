# Class: workstation::system
#
# This class initialize system utils and give access to CPU
# temperature and system management.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::system
#
class workstation::system {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    'hwstat',
    'gotop'
  ]: }

  file_line { 'Enable coretemp in /boot/loader.conf':
    path => '/boot/loader.conf',
    line => 'coretemp_load="YES"'
  }
}
