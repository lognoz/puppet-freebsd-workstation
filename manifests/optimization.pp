# Class: workstation::optimization
#
# This class install some programs and change system configurations to
# make FreeBSD usable as a desktop station.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::optimization
#
class workstation::optimization {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  package { [
    'hwstat',
    'gotop'
  ]: }

  workstation::system { 'Optimize boot loader':
    path => '/boot/loader.conf',
    content => [
      # Change boot time kernel tuning.
      'kern.ipc.shmseg = 1024',
      'kern.ipc.shmmni = 1024',
      'kern.maxproc = 100000',

      # Configuring asynchronous I/O.
      'aio_load = "YES"',

      # Enable thermal sensors.
      'coretemp_load="YES"'
    ]
  }

  workstation::system { 'Optimize system control':
    path => '/etc/sysctl.conf',
    content => [
      # Configuring the scheduler for desktop use.
      'kern.sched.preempt_thresh = 224',

      # Increasing the maximum number of files open.
      'kern.maxfiles = 200000',

      # Avoid creating a core file.
      'kern.coredump = 0',

      # Extend X11 interface for shared memory.
      'kern.ipc.shmmax = 67108864',
      'kern.ipc.shmall = 32768'
    ]
  }
}
