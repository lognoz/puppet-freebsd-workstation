# Class: workstation::x11::dwm
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
  include workstation::x11::xorg

  exec { 'Install dwm package':
    cwd => '/usr/ports/x11-wm/dwm/',
    unless => 'which dwm',
    command => "make DWM_CONF=${workstation::root}/files/x11/wm-config.c clean install",
  }

  exec { 'Lock dwm package':
    command => 'yes | pkg lock dwm'
  }

  workstation::x11::conf { [
    'xsetroot -name " "',
    'exec dwm'
  ]: }
}
