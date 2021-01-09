# Class: workstation::programming::web::npm
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming::web:npm
#
class workstation::programming::web::npm (
  $packages = [
    'grunt-cli',
    'psd-cli'
  ]
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { 'npm-node12': }

  $packages.each |String $package| {
    exec { "npm install -g ${package}": }
  }
}
