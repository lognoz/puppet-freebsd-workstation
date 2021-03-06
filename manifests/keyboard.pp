# Class: workstation::keyboard
#
# This class sets keyboard in xorg. For each input device (keyboard,
# mouse, etc.) it need an InputClass section.
#
# Variables:
#   `keyboard` — Type: *string* — Default: *undef*
#   String used as kbd layout.
#
#   `remap_caps` — Type: *boolean* — Default: *true*
#   Boolean on if caps lock is replaced by escape.
#
# Requires:
#   Class workstation::x11::xorg
#
# Sample Usage:
#   class { 'workstation::keyboard':
#     keyboard => 'us,ca'
#   }
#
class workstation::keyboard (
  String $keyboard = undef,
  Boolean $remap_caps = true
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation
  include workstation::x11::xorg

  file { '/usr/local/etc/X11/xorg.conf.d/00-keyboard.conf':
    content => template('workstation/xorg-keyboard.erb')
  }
}
