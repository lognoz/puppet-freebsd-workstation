# Class: workstation::programming::python
#
# This class initialize Python programming language.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming::python
#
class workstation::programming::python {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    'python37',
    'py37-pip-run'
  ]: }
}
