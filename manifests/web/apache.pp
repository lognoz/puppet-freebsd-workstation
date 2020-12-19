# Class: workstation::web::apache
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::web:apache
#
class workstation::web::apache {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
  }

  include workstation::web::php
  include workstation::web::mysql

  class { 'apache': }

  apache::vhost { 'localhost':
    docroot => '/home/lognoz/www/',
    docroot_owner  => $workstation::username,
    docroot_group  => $workstation::username
  }

  apache::vhost { 'mysql.localhost':
    docroot => '/usr/local/www/phpMyAdmin/'
  }

  file { '/usr/local/etc/apache24/modules.d/001_mod-php.conf':
    source => 'puppet:///modules/workstation/mod-php.conf',
  }

  file_line { 'Add PHP library to httpd.conf':
    path => '/usr/local/etc/apache24/httpd.conf',
    line => 'LoadModule php7_module libexec/apache24/libphp7.so'
  }

  file_line { 'Configure Apache to speak PHP':
    path => '/usr/local/etc/apache24/httpd.conf',
    line => 'Include "/usr/local/etc/apache24/modules.d/001_mod-php.conf"'
  }
}
