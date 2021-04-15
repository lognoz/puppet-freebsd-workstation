# Class: workstation::multimedia::wget
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::multimedia::wget
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

  $wget = "wget --directory-prefix=\"~/${directory}/$(date +'%Y-%m-%d.%s')/\""

  workstation::bash::alias { [
    "get='${wget}'",
    "index='${wget} --recursive --no-parent --no-host-directories --reject=\"index.html?*\"'"
  ]: }
}
