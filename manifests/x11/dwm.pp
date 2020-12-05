# Define: workstation::x11:dwm
#
# This module manages Dynamic Windows Manager installation.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::x11:dwm
#
class workstation::x11::dwm {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation
  include workstation::fonts

  Exec {
    path => [
      '/bin/',
      '/sbin/',
      '/usr/bin/',
      '/usr/sbin/',
      '/usr/local/bin/'
    ]
  }

  exec { "make DWM_CONF=${workstation::root}/files/x11/wm-config.c clean install":
    cwd => '/usr/ports/x11-wm/dwm/',
    unless => 'which dwm'
  }

  workstation::x11::conf { [
    'xsetroot -name " "',
    'exec dwm'
  ]: }
}
