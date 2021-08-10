# Class: workstation::sudo
#
# This class initialize sudo package. This program is designed to
# allow a sysadmin to give limited root privileges to users and log
# root activity.
#
# Requires:
#   Class workstation
#
# Vulnerability:
#
#   I now use doas instead of sudo because a severe vulnerability was
#   found in Unix and Linux operating systems that allows an
#   unprivileged user to exploit this vulnerability using sudo, causing
#   a heap overflow to elevate privileges to root without
#   authentication, or even get listed in the sudoers
#   file. (CVE-2021-3156)
#
# Sample Usage:
#   include workstation::sudo
#
class workstation::sudo {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
  }

  class { 'sudo': }

  sudo::conf { "${workstation::username}-all":
    priority => 10,
    content  => "${workstation::username} ALL=(ALL) ALL",
  }
}
