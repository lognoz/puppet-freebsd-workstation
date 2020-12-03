# FreeBSD Powerd Support
#
# This class initialize powerd package. This program utility monitors
# the system state and sets various power control options accordingly.
#
class workstation::powerd {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { 'powerdxx': }

  file_line { 'Disable powerd in /etc/rc.conf':
    path   => '/etc/rc.conf',
    line   => 'powerd_enable="NO"',
    match  => 'powerd_enable="YES"'
  }

  file_line { 'Enable powerdxx in /etc/rc.conf':
    path => '/etc/rc.conf',
    line => 'powerdxx_enable="YES"'
  }
}
