# Class: workstation::browser::firefox
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::browser:firefox
#
class workstation::browser::firefox (
  Array $extensions = [
    'https://addons.mozilla.org/firefox/downloads/file/3679754/ublock_origin-1.31.0-an+fx.xpi',
    'https://addons.mozilla.org/firefox/downloads/file/3679479/https_everywhere-2020.11.17-an+fx.xpi',
    'https://addons.mozilla.org/firefox/downloads/file/3690660/user_agent_switcher-1.4.1-an+fx.xpi'
  ]
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation
  include workstation::browser::wget

  $path = "/home/${workstation::username}/.mozilla/extensions/"

  package { 'firefox': }

  exec { "Create ${path}":
    creates => $path,
    command => "mkdir -p ${path}",
    path => "/bin",
    user  => $workstation::username
  }

  wget::retrieve { $extensions:
    destination => $path
  }
}
