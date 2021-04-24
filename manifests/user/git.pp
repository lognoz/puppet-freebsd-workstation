# Class: workstation::user::git
#
# This class initialize git package. This program is a distributed
# version-control system for tracking changes in source code during
# software development.
#
# Variables:
#   [*username*] — Type: `string` Default: `undef`
#   Content of git user name.
#
#   [*email*] — Type: `string` Default: `undef`
#   Content of git user email.
#
#   [*url*] — Type: `hash|undef` Default: `undef`
#   Hash of git url to be rewritten.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::user::git':
#     username  => 'Marc-Antoine Loignon',
#     email => 'developer@lognoz.org'
#     urls => {
#       'https://lognoz@github.com' => 'https://github.com',
#     }
#   }
#
class workstation::user::git (
  String $username = undef,
  String $email = undef,
  Variant[Hash, Undef] $urls = undef
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
