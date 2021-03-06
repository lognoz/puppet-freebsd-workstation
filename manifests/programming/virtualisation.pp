# Class: workstation::programming::virtualisation
#
# This class initialize virtualisation program like *Vagrant*,
# *Docker* and *Virtualbox*.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming:virtualisation
#
class workstation::programming::virtualisation {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    "vagrant",
    "docker",
    "virtualbox-ose"
  ]: }
}
