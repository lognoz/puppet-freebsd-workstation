# Class: workstation::multimedia::youtube_dl
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::multimedia::youtube_dl
#
class workstation::multimedia::youtube_dl (
  String $directory = 'video'
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
  }

  package { 'youtube_dl': }

  workstation::bash::rc {
    "alias youtube='youtube-dl -o \"~/${directory}/%(title)s-%(id)s.%(ext)s\"'":
  }
}
