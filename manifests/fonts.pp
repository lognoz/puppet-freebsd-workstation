# Class: workstation::fonts
#
# This class install system fonts.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::fonts
#
class workstation::fonts {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    'sourcecodepro-ttf',
    'roboto-fonts-ttf'
  ]: }

  workstation::x11::conf { [
    'FontPath "/usr/local/share/fonts/SourceCodePro/"',
    'FontPath "/usr/local/share/fonts/roboto-fonts-ttf/"'
  ]: }
}
