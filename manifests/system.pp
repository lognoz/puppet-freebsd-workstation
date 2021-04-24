# Define: workstation::system
#
# This module manages system configurations.
#
# Variables:
#   [*path*] — Type: `string` Default: `undef`
#   String use as path location to add content.
#
#   [*content*] — Type: `array` Default: `undef`
#   List of lines to add to the path location.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   workstation::system { 'Optimize boot loader':
#     path => '/boot/loader.conf',
#     content => [
#       # Change boot time kernel tuning.
#       'kern.ipc.shmseg = 1024',
#       'kern.ipc.shmmni = 1024',
#       'kern.maxproc = 100000',
#
#       # Configuring asynchronous I/O.
#       'aio_load = "YES"',
#
#       # Enable thermal sensors.
#       'coretemp_load="YES"'
#     ]
#   }
#
define workstation::system (
  String $path = undef,
  Array $content = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  $content.each |String $line| {
    file_line { "Add ${line} to ${path}":
      path => $path,
      line => $line
    }
  }
}
