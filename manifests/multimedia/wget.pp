# Class: workstation::multimedia::wget
#
# This initialize wget package. This computer program that retrieves
# content from web servers.
#
# Variables:
#   `directory` — Type: *string* — Default: *download*
#   String used as download directory for torrent file.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::multimedia::wget':
#     directory => 'download/wget'
#   }
#
class workstation::multimedia::wget (
  String $directory = 'download'
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  class { 'wget':
    package_manage => true,
    package_ensure => present,
    package_name   => 'wget',
  }

  workstation::bash::alias { [
    "wget='wget --directory-prefix=\"~/${directory}/$(date +'%Y-%m-%d.%s')/\"'",
    "wget-index='wget --recursive --no-parent --no-host-directories --reject=\"index.html?*\"'"
  ]: }
}
