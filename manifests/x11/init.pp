# FreeBSD Init Support
#
# This class sets xinitrc content. This program allows a user to
# manually start an Xorg display server.
#
# $append   String used to append in .xinitrc file.
#
class workstation::x11::init (
  String $content = undef
) {
  # Make sure this subclasses is executed after xorg is loaded.
  if ! defined(Class['workstation::x11::xorg']) {
    fail('You must include the xorg workstation class before using any subclasses.')
  }

  include workstation

  file_line { 'Add line to ~/.xinitrc':
    ensure => present,
    path   => "/home/${workstation::username}/.xinitrc",
    line   => $content,
    match  => "^$content"
  }
}
