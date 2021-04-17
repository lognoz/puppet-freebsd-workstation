# Class: workstation::security
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::security
#
class workstation::security {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  workstation::system { 'Improve system security':
    path => '/etc/rc.conf',
    content => [
      # Ensure syslogd does not bind to a network socket if you are not
      # logging into a remote machine.
      'syslogd_flags="-ss"',

      # ICMP Redirect messages can be used by attackers to redirect
      # traffic and should be ignored.
      'icmp_drop_redirect="YES"',

      # Sendmail is an insecure service and should be disabled.
      'sendmail_enable="NO"'
    ]
  }
}
