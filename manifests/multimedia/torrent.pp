# Class: workstation::multimedia::torrent
#
# This class initialize transmission package. This program is a lightweight,
# command-line BitTorrent client with scripting capabilities.
#
# Variables:
#   [*directory*] — Type: `string` Default: `download`
#   String used as download directory for torrent file.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::multimedia::torrent':
#     directory => 'download/torrent'
#   }
#
class workstation::multimedia::torrent (
  String $directory = 'download'
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

  workstation::bash::alias {
    "torrent='transmission-cli --download-dir ~/${directory}'":
  }
}
