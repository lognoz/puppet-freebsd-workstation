# Define: workstation::shell::bin
#
# This module manages shell executable.
#
# Variables:
#   `content` — Type: *string* — Default: *undef*
#   Script content in file.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   workstation::shell::bin { 'torrent':
#     content => template('workstation/bin/torrent.erb')
#   }
#
define workstation::shell::bin (
  String $content = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  $bin_directory = "/${workstation::home}/.local/bin"

  file { $bin_directory:
    ensure => directory,
    owner => $workstation::username,
    group => $workstation::username,
    mode  => '0755'
  }

  file { "${bin_directory}/${title}":
    ensure  => present,
    content => $content,
    owner => $workstation::username,
    group => $workstation::username,
    mode  => 'u+x'
  }
}
