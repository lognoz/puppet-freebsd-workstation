# Class: workstation::package
#
# This class sets FreeBSD package configurations.
#
# Parameters:
#   [*prefer_yes*]
#     Boolean used to make yes option the default operations
#     for dialog. Most pkg operations offer a yes/no
#     question, showing the default as a capital letter.
#     Being conservative, pkg normally defaults to no.
#     Default: true
#
#   [*autoclean*]
#     Boolean used to automatically clean out the content of
#     pkg cache after each non dry-run call to 'pkg install'
#     or 'pkg upgrade'.
#     Default: true
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::package
#
class workstation::package (
  Boolean $prefer_yes = true,
  Boolean $autoclean = true
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  file { '/usr/local/etc/pkg.conf':
    ensure => present,
    owner  => 'root',
    group  => 'wheel',
    mode   => '0644',
    content => template('workstation/package.erb')
  }
}
