# Class: workstation::git
#
# This class initialize git package. This program is a distributed
# version-control system for tracking changes in source code during
# software development.
#
# Parameters:
#   [*username*]
#     Content of git user name.
#     Default: undef
#
#   [*email*]
#     Content of git user email.
#     Default: undef
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::git':
#     username  => 'Marc-Antoine Loignon',
#     email => 'developer@lognoz.org'
#   }
#
class workstation::git (
  String $username = undef,
  String $email = undef
) {
  # Make sure this subclasses is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
  }

  package { 'git': }

  file { "/home/${workstation::username}/.gitconfig":
    ensure  => present,
    owner   => $workstation::username,
    group   => $workstation::username,
    content => template('workstation/gitconfig.erb')
  }
}
