# Class: workstation
#
# This class sets root and user for FreeBSD systems. Make sure to load
# this file before any workstation subclasses.
#
# Variables:
#   `username` — Type: *string* — Default: *undef*
#   String used to create user and its home directory.
#
#   `password` — Type: *string* — Default: *undef*
#   String used as user and root password.
#
#   `timezone` — Type: *string* — Default: *undef*
#   String used as timezone reference.
#
#   `owner_name` — Type: *string* — Default: *undef*
#   String used as computer owner name.
#
#   `owner_email` — Type: *string* — Default: *undef*
#   String used as computer owner email.
#
#   `shell` — Type: *string* — Default: *bash*
#   String used as shell program. If you use zsh on FreeBSD,
#   you will send "zsh" and puppet will install the dependencies.
#
#   `root` — Type: *string* — Default: */usr/local/etc/puppet/modules/workstation/*
#   The reference on where the workstation module is located.
#
# Sample Usage:
#   class { 'workstation':
#     username => 'lognoz',
#     owner_name => 'Marc-Antoine Loignon',
#     owner_email => 'developer@lognoz.org',
#     timezone => 'America/New_York',
#     password => $password
#   }
#
class workstation (
  String $username = undef,
  String $password = undef,
  String $timezone = undef,
  String $owner_name = undef,
  String $owner_email = undef,
  String $root = '/usr/local/etc/puppet/modules/workstation/',
  String $shell = 'bash'
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
  # install and use bash.
  if $shell == 'bash' {
    $processor = '/usr/local/bin/bash'
  }
  elsif $shell == 'zsh' {
    $processor = '/usr/local/bin/zsh'
  }
  else {
    fail("Parameter shell '${shell}' is not supported.")
  }

  class { 'workstation::shell':
    processor => $processor
  }

  class { 'timezone':
    timezone => $timezone
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
    password => $hash,
    shell => $processor
  }

  if !defined(User[$username]){
    user { $username:
      ensure     => present,
      managehome => true,
      shell      => $processor,
      comment    => $username,
      gid        => $username,
      home       => $home,
      name       => $username,
      password   => $hash,
      require    => [ Group[$username] ]
    }
  } else {
    user { $username:
      ensure   => present,
      password => $hash
    }
  }
}
