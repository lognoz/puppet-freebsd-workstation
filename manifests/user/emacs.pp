# Class: workstation::user:emacs
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::user::emacs':
#     source => 'https://github.com/lognoz/embla'
#   }
#
class workstation::user::emacs (
  String $source  = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
  }

  package { 'emacs': }

  vcsrepo { 'Clone Emacs configuration':
    ensure   => present,
    provider => git,
    path     => "/home/${workstation::username}/.emacs.d",
    user     => $workstation::username,
    source   => $source
  }
}
