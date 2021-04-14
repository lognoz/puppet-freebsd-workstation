# Class: workstation::programming::latex
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming::latex
#
class workstation::programming::latex {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    'tex-luatex',
    'tex-xetex'
  ]: }
}
