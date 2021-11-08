# Define: workstation::shell::rc
#
# This module manages shellrc configurations.
#
# Variables:
#   `content` — Type: *string|array* — Default: *$title*
#   Content of configuration to append.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   workstation::shell::rc {
#     'alias ls="ls -F"':
#   }
#
define workstation::shell::rc (
  Variant[String, Array] $content = $title
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation::shell']) {
    fail('You must include the base workstation:shell class before using any subclasses.')
  }

  if $content.is_a(String) {
    $lines = [ $content ]
  } else {
    $lines = $content
  }

  $rc = $workstation::shell::rc
  $path = "${workstation::home}/${rc}"

  $lines.each |String $text| {
    file_line { "Append ${text} to ${rc}":
      ensure => present,
      path   => $path,
      line   => $text,
      match  => "^${text}"
    }
  }
}
