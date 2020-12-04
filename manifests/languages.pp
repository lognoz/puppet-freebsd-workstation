# FreeBSD Languages Support
#
# This class sets keyboard in xorg. For each input device (keyboard,
# mouse, etc.) it need an InputClass section.
#
# $keyboard  String used as kbd layout.

# $aspell    Array of languages to install via Freebsd ports. Make
#            sure to have the right package name before to call this
#            class.
#
class workstation::languages (
  String $keyboard = undef,
  Array $aspell = undef
) {
  # Make sure this subclasses is executed after xorg is loaded.
  if ! defined(Class['workstation::x11::xorg']) {
    fail('You must include the xorg workstation class before using any subclasses.')
  }

  package { 'aspell-ispell': }

  $aspell.each |String $language| {
    package { "${language}-aspell": }
  }

  file { '/usr/local/etc/X11/xorg.conf.d/00-keyboard.conf':
    content => template('workstation/xorg-keyboard.erb')
  }
}
