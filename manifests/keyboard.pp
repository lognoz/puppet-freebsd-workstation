# Class: workstation::keyboard
#
# This class sets keyboard in xorg. For each input device (keyboard,
# mouse, etc.) it need an InputClass section.
#
# Parameters:
#   [*keyboard*]
#     String used as kbd layout.
#     Default: undef
#
#   [*aspell*]
#     Array of languages to install via Freebsd ports. Make sure
#     to have the right package name before to call this class.
#     Default: undef
#
# Requires:
#   Class workstation::x11::xorg
#
# Sample Usage:
#   class { 'workstation::languages':
#     keyboard => 'us,ca',
#     aspell => ['en','fr']
#   }
#
class workstation::keyboard (
  String $keyboard = undef,
  Array $aspell = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation
  include workstation::x11::xorg

  package { 'aspell-ispell': }

  $aspell.each |String $language| {
    package { "${language}-aspell": }
  }

  file { '/usr/local/etc/X11/xorg.conf.d/00-keyboard.conf':
    content => template('workstation/xorg-keyboard.erb')
  }
}
