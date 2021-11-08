# Class: workstation::user::directories
#
# This class manages custom directories and xdg-user-dirs, a tool to
# help manage well known user directories like the desktop folder and
# the music folder.
#
# Variables:
#   `desktop` — Type: *string* — Default: */*
#   The desktop user directory
#
#   `document` — Type: *string* — Default: */document*
#   The document user directory
#
#   `download` — Type: *string* — Default: */download*
#   The download user directory
#
#   `music` — Type: *string* — Default: */music*
#   The music user directory
#
#   `picture` — Type: *string* — Default: */picture*
#   The picture user directory
#
#   `public` — Type: *string* — Default: */public*
#   The public user directory
#
#   `template` — Type: *string* — Default: */template*
#   The template user directory
#
#   `video` — Type: *string* — Default: */video*
#   The video user directory
#
#   `directories` — Type: *array* — Default: *[]*
#   The list of directories that need to be created
#
# Requires:
#   Class workstation
#
# Sample Usage:
#  class { 'workstation::user::directories':
#    download => '/download/browser',
#    directories => [
#      '/download',
#      '/document',
#      '/program',
#      '/video'
#    ]
#  }
#
class workstation::user::directories (
  String $desktop  = '/',
  String $document = '/document',
  String $download = '/download',
  String $music    = '/music',
  String $picture  = '/picture',
  String $public   = '/public',
  String $template = '/template',
  String $video    = '/video',
  Array $directories = []
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { 'xdg-user-dirs': }

  File {
    owner => $workstation::username,
    group => $workstation::username,
    mode  => '0755'
  }

  file { "${workstation::home}/.config":
    ensure => directory
  }

  file { "${workstation::home}/.config/user-dirs.dirs":
    ensure  => present,
    content => template('workstation/user-dirs.erb')
  }

  $directories.each |String $directory| {
    file { "${workstation::home}/${directory}":
      ensure => directory
    }
  }
}
