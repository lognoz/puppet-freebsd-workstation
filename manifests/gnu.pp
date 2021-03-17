# Class: workstation::gnu
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::gnu
#
class workstation::gnu {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    'gcc',
    'gmake',
    'libtool'
  ]: }
}
