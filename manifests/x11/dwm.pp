class workstation::x11::dwm {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  Exec {
    path => [
      '/bin/',
      '/sbin/',
      '/usr/bin/',
      '/usr/sbin/',
      '/usr/local/bin/'
    ]
  }

  exec { 'make clean install':
    cwd => '/usr/ports/x11-wm/dwm/',
    unless => 'which dwm'
  }

  workstation::x11::conf {
    'exec dwm':
  }
}
