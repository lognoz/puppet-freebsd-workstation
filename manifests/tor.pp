# Class: workstation::tor
#
# This class initialize tor, a software for enabling anonymous
# communication by directing Internet traffic.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::tor
#
class workstation::tor {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    'ca_root_nss',
    'obfs4proxy-tor',
    'torsocks',
    'tor'
  ]: }

  workstation::system { 'Ensure net.inet.ip.random_id is enabled':
    path => '/etc/sysctl.conf',
    content => [
      'net.inet.ip.random_id=1'
    ]
  }

  workstation::system { 'Start tor at boot time and use the setuid feature':
    path => '/etc/rc.conf',
    content => [
      'tor_setuid="YES"',
      'tor_enable="YES"'
    ]
  }
}
