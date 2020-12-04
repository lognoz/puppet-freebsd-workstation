# FreeBSD Xorg Support
#
# This class sets xorg package. Xorg (commonly referred as simply X)
# is the most popular display server among Linux and BSD users.
#
class workstation::xorg {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    'xorg',
    'xorg-apps',
    'xbindkeys',
    'xclip',
    'xinit',
    'xterm',
    'xrandr'
  ]: }
}
