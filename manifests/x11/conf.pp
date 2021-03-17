# Define: workstation::x11:conf
#
# This module manages Xorg configurations.
#
# Parameters:
#   [*content*]
#     Content of configuration to append.
#     Default: $title
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   workstation::x11::conf {
#     'xmodmap ~/.Xmodmap'
#   }
#
define workstation::x11::conf (
  Variant[String, Array] $content = $title
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation
  include workstation::x11::xorg

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
