# Class: workstation::programming::python
#
# This class initialize Python programming language.
#
# Variables:
#   `version` — Type: *string* — Default: *38*
#   The python version that need to be installed.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming::python
#
class workstation::programming::python (
  String $version = '38'
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    "python${version}",
    "py${version}-pip",
    "py${version}-pip-run"
  ]: }
}
