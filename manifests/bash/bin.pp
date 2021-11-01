# Define: workstation::bash::bin
#
# This module manages bash executable.
#
# Variables:
#   `content` — Type: *string|array* — Default: *$title*
#   Content of bin to append.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   workstation::bash::bin { 'torrent':
#     content => template('workstation/bin/torrent.erb')
#   }
#
define workstation::bash::bin (
  String $content = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  $bin_directory = "/home/${workstation::username}/.local/bin"

  include workstation
  include workstation::bash::init

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
