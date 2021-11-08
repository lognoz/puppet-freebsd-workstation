# Class: workstation::graphic
#
# This class add graphics support to make FreeBSD usable as a desktop.
# It only supports Intel HD and NVIDIA graphics cards.
#
# Variables:
#   `hardware` — Type: *string* — Default: *undef*
#   String used to install the right graphic card.
#   It expected to recives *intel* or *nvidia*.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::graphic':
#     hardware => 'nvidia'
#   }
#
class workstation::graphic (
  String $hardware = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  if $hardware == 'intel' {
    package { 'drm-kmod': }

    file_line { 'Add kld to /etc/rc.conf':
      ensure => present,
      path   => '/etc/rc.conf',
      line   => 'kld_list="/boot/modules/i915kms.ko"',
      match  => '^kld_list'
    }
  }
  elsif $hardware == 'nvidia' {
    package { 'nvidia-driver': }

    file_line { 'Add nvidia to /boot/loader.conf':
      ensure => present,
      path   => '/boot/loader.conf',
      line   => 'nvidia_load="YES"',
      match  => '^nvidia_load'
    }

    file_line { 'Add kld to /etc/rc.conf':
      ensure => present,
      path   => '/etc/rc.conf',
      line   => 'kld_list="nvidia-modeset"',
      match  => '^kld_list'
    }
  }
  else {
    fail("Parameter hardware '${hardware}' is not supported.")
  }
}
