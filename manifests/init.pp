# FreeBSD User Support
#
# This class sets root and user for FreeBSD systems. Make sure to load
# this file before any workstation subclasses.
#
# $username   String used to create user and its home directory.
#
# $password   String used as user and root password.
#
# $timezone   String used as timezone reference.
#
# $shell      String used as command processor path. If you use zsh
#             on FreeBSD, you will send /usr/bin/zsh. By default, this
#             class will install and use bash if $shell is undefined.
#
class workstation (
  String $username = undef,
  String $password = undef,
  String $timezone = undef,
  String $root = '/usr/local/etc/puppet/modules/workstation/',
  Variant[String, Undef] $shell = undef
) {
  # Make sure this script is executed in FreeBSD.
  if $::osfamily != 'FreeBSD' {
    fail("${::operatingsystem} not supported")
  }

  # Define home directory or throw an error if username is not valid.
  if $username =~ /^[a-zA-Z0-9_]+$/ {
    $home = "/home/${username}"
  } else {
    fail('Parameter username must be alphanumeric.')
  }

  # Make sure that by default ensure is present before to install any
  # packages.
  Package {
    ensure => present
  }

  # Make sure that the Free Software Fondation core utils is installed
  # on the system. This package give access to GNU commands like ls,
  # kill, cat, etc.
  package { 'coreutils': }

  # Define command processor if it's not defined. By default, it will
  # install and use bash. If you define your own executable shell,
  # make sure to install it before to call this class.
  if $shell == undef {
    package { 'bash': }
    $processor = '/usr/local/bin/bash'
  } else {
    $processor = $shell
  }

  class { 'timezone':
    timezone => $timezone
  }

  user { $username:
    ensure     => present,
    managehome => true,
    shell      => $processor,
    comment    => $username,
    gid        => $username,
    home       => $home,
    name       => $username,
    require    => [ Group[$username] ]
  }

  group { $username:
    ensure => present,
    name   => $username,
    system => false
  }

  $salt = seeded_rand_string(20, '')
  $hash = pw_hash($password, 'SHA-512', $salt)

  user { 'root':
    ensure   => present,
    password => $hash
  }

  User[$username] {
    password => $hash
  }
}
