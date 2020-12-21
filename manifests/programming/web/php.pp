# Class: workstation::programming::web::php
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming::web:php
#
class workstation::programming::web::php {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { 'mod_php74': }

  class { 'php::globals':
    php_version => '7.4'
  }

  class { 'php':
    ensure       => latest,
    manage_repos => true,
    fpm          => true,
    dev          => true,
    composer     => true,
    pear         => true,
    phpunit      => false,
    settings     => {
      'PHP/max_execution_time'  => '90',
      'PHP/max_input_time'      => '300',
      'PHP/memory_limit'        => '64M',
      'PHP/post_max_size'       => '32M',
      'PHP/upload_max_filesize' => '32M',
    }
  }
}
