# FreeBSD Xorg Conf
#
# This class sets xinitrc content. This program allows a user to
# manually start an Xorg display server.
#
# $content   String or array used to append in .xinitrc file.
#
define workstation::x11::conf (
  Variant[String, Array] $content = $title
) {
  # Make sure this subclasses is executed after xorg is loaded.
  if ! defined(Class['workstation::x11::xorg']) {
    fail('You must include the xorg workstation class before using any subclasses.')
  }

  include workstation

  if $content.is_a(String) {
    $lines = [ $content ]
  } else {
    $lines = $content
  }

  $lines.each |String $text| {
    file_line { "Append ${text} to xinitrc":
      ensure => present,
      path   => "/home/${workstation::username}/.xinitrc",
      line   => $text,
      match  => "^${text}"
    }
  }
}
