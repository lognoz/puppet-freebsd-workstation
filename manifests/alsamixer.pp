# Class: workstation::alsamixer
#
# This class initialize alsamixer package. This program is a graphical
# mixer program for the Advanced Linux Sound Architecture that is used
# to configure sound settings and adjust the volume.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::alsamixer
#
class workstation::alsamixer {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { 'alsa-utils': }
}
