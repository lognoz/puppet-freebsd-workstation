# Define: workstation::shell::alias
#
# This module manages shell aliases configurations.
#
# Variables:
#   `content` — Type: *string|array* — Default: *$title*
#   Content of configuration to append.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   workstation::shell::alias { [
#     'ls="ls -F"',
#     'll="ls -lah"',
#     'emacs="emacs --maximized"'
#   ]: }
#
define workstation::shell::alias (
  Variant[String, Array] $content = $title
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  if $content.is_a(String) {
    $lines = [ $content ]
  } else {
    $lines = $content
  }

  $path = "${workstation::home}/.aliases"

  $lines.each |String $text| {
    file_line { "Append ${text} to aliases":
      ensure => present,
      path   => $path,
      line   => "alias ${text}",
      match  => "^alias ${text}"
    }
  }
}
