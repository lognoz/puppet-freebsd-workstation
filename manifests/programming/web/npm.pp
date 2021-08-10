# Class: workstation::programming::web::npm
#
# This class initialize npm package. This program is a package manager
# for the JavaScript programming language.
#
# Variables:
#   `packages` — Type: *array* — Default: *undef*
#   List of packages to be install globally.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming::web:npm
#
class workstation::programming::web::npm (
  Array $packages = [
    'grunt-cli',
    'psd-cli',
    'tern'
  ]
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { 'npm-node14': }

  $packages.each |String $package| {
    exec { "npm install -g ${package}": }
  }
}
