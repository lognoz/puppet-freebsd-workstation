# Class: workstation::user::vim
#
# This class initialize Vim package. This program is a highly
# configurable text editor built to make creating and changing any
# kind of text very efficient.
#
# Variables:
#   [*source*] — Type: `string` Default: `undef`
#   The git repository of vim configuration.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::user::vim':
#     source => 'https://github.com/lognoz/vimrc'
#   }
#
class workstation::user::vim (
  String $source  = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
  }

  package { 'vim': }

  vcsrepo { 'Clone Vim configuration':
    ensure   => present,
    provider => git,
    path     => "/home/${workstation::username}/.vim",
    user     => $workstation::username,
    source   => $source
  }
}
