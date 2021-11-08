# Class: workstation::user::emacs
#
# This class initialize Emacs package. This program is a highly
# customizable editor indeed, it has been customized to the point
# where it is more like an operating system than an editor!
#
# Variables:
#   `source` — Type: *string|undef* — Default: *undef*
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
  Variant[String, Undef] $source = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation
  include workstation::gnu
  include workstation::programming::python

  # Install Emacs development version.
  package { 'emacs-devel': }

  # This python package is used to slugify files in dired mode.
  $python_version = $workstation::programming::python::version
  package { "py${python_version}-python-slugify": }

  workstation::shell::alias { [
    "emacs='emacsclient -c -a \"emacs\"'"
  ]: }

  if $source != undef {
    if defined(Class['workstation::user::dotfiles']) and $workstation::user::dotfiles::use_stow == true {
      $emacs_path = $workstation::user::dotfiles::path
    } else {
      $emacs_path = $workstation::home
    }

    vcsrepo { 'Clone Emacs configuration':
      ensure   => present,
      provider => git,
      path     => "${emacs_path}/.emacs.d",
      user     => $workstation::username,
      source   => $source
    }
  }
}
