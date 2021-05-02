# Class: workstation::programming::web::mysql
#
# This class initialize MySQL database server.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming::web:mysql
#
class workstation::programming::web::mysql {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { 'phpMyAdmin5-php74': }

  class { 'mysql::server':
    package_name => 'mariadb105-server',
    config_file  => '/usr/local/etc/mysql/conf.d/server.cnf',
    root_password => '',
    restart => true,
    override_options => {
      'mysqld' => {
        'event_scheduler' => 'on'
      }
    }
  }

  file_line { 'Change host in phpMyAdmin':
    path => '/usr/local/www/phpMyAdmin/config.sample.inc.php',
    line => '$cfg[\'Servers\'][$i][\'host\'] = \'mysql.localhost\';'
  }

  file_line { 'Enable no password in phpMyAdmin':
    path => '/usr/local/www/phpMyAdmin/config.sample.inc.php',
    line => '$cfg[\'Servers\'][$i][\'AllowNoPassword\'] = true;'
  }

  file_line { 'Change user to root in phpMyAdmin':
    path => '/usr/local/www/phpMyAdmin/config.sample.inc.php',
    line => '$cfg[\'Servers\'][$i][\'user\'] = \'root\';'
  }

  file { '/usr/local/www/phpMyAdmin/config.inc.php':
    ensure => present,
    source => '/usr/local/www/phpMyAdmin/config.sample.inc.php'
  }
}
