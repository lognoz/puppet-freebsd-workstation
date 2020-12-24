# Define: workstation::bash::rc
#
# This module manages bashrc configurations.
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
#   workstation::bash::rc {
#     'alias ls="ls -F"'
#   }
#
define workstation::bash::rc (
  Variant[String, Array] $content = $title
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation
  include workstation::bash::init

  if $content.is_a(String) {
    $lines = [ $content ]
  } else {
    $lines = $content
  }

  $path = "/home/${workstation::username}/.bashrc"

  $lines.each |String $text| {
    file_line { "Append ${text} to bashrc":
      ensure => present,
      path   => $path,
      line   => $text,
      match  => "^${text}"
    }
  }
}
