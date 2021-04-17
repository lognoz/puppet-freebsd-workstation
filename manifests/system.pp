# Define: workstation::system
#
# This module manages system configurations.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::system
#
define workstation::system (
  String $path = undef,
  Array $content = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  $content.each |String $line| {
    file_line { "Add ${line} to ${path}":
      path => $path,
      line => $line
    }
  }
}
