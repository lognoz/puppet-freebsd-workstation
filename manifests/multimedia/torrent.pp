# Class: workstation::multimedia::torrent
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::multimedia:torrent
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

  package { 'transmission-cli': }

  workstation::bash::rc {
    "alias torrent='transmission-cli --download-dir /home/${workstation::username}/${directory}'":
  }
}
