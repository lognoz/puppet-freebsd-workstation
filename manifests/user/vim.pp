# Class: workstation::user:vim
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
