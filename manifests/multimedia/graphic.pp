# Class: workstation::multimedia::graphic
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::multimedia:graphic
#
class workstation::multimedia::graphic {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    'gimp',
    'blender',
    'vlc'
  ]: }
}
