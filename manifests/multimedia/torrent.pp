# Class: workstation::multimedia::torrent
#
# This class initialize transmission package. This program is a lightweight,
# command-line BitTorrent client with scripting capabilities.
#
# Variables:
#   `destination` — Type: *string* — Default: *download*
#   String used as destination directory for torrent file.
#
#   `source` — Type: *string* — Default: *download*
#   String used as source directory for torrent file.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::multimedia::torrent':
#     destination => 'download/torrent',
#     source => 'download/browser'
#   }
#
class workstation::multimedia::torrent (
  String $destination = 'download',
  String $source = 'download'
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
  }

  package {
    'transmission-cli':
  }

  # workstation::bash::bin {
  #   'PS1="\W \$ "':
  # }

  workstation::bash::bin { 'torrent':
    content => template('workstation/bin/torrent.erb')
  }
}
