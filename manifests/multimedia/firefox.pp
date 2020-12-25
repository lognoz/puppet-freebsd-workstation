# Class: workstation::multimedia::firefox
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::multimedia:firefox
#
class workstation::multimedia::firefox (
  Array $extensions = []
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation
  include workstation::multimedia::wget

  $path = "/home/${workstation::username}/.mozilla/extensions/"

  exec { "Create ${path}":
    creates => $path,
    command => "mkdir -p ${path}",
    path => "/bin",
    user  => $workstation::username
  }

  $extensions.each |String $package| {
    wget::retrieve { "Download ${package}":
      source => "https://addons.mozilla.org/firefox/downloads/file/${package}",
      destination => $path,
      timeout => 0,
      verbose => false
    }
  }
}
