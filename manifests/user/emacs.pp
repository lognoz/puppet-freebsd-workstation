# Class: workstation::user:emacs
#
# This class initialize Emacs package. This program is a highly
# customizable editor indeed, it has been customized to the point
# where it is more like an operating system than an editor!
#
# Variables:
#   [*source*] — Type: `string` Default: `undef`
#   The git repository of Emacs configuration.
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
  }

  include workstation
  include workstation::gnu

  package { [
    'emacs-devel',
    'py37-python-slugify'
  ]: }

  vcsrepo { 'Clone Emacs configuration':
    ensure   => present,
    provider => git,
    path     => "/home/${workstation::username}/.emacs.d",
    user     => $workstation::username,
    source   => $source
  }
}
