# Class: workstation::multimedia::youtube_dl
#
# This class initialize youtube-dl package. This program is an
# open-source download manager for video and audio from YouTube and
# over 1000 other video hosting websites.
#
# Variables:
#   `directory` — Type: *string* — Default: *video*
#   String used as download directory for torrent file.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::multimedia::youtube_dl':
#     directory => 'video/youtube'
#   }
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

  workstation::bash::alias {
    "youtube='youtube-dl -o \"~/${directory}/%(title)s-%(id)s.%(ext)s\"'":
  }
}
