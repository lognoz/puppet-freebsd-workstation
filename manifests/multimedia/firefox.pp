# Class: workstation::multimedia::firefox
#
# This class initialize Firefox package. This program, also known as
# Mozilla Firefox, is a free and open-source web browser developed by
# the Mozilla Foundation and its subsidiary, the Mozilla Corporation.
#
# Variables:
#   `extensions` — Type: *array* — Default: *[]*
#   List of extensions that you want to install in Firefox.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   class { 'workstation::multimedia::firefox':
#     extensions => [
#       '3679754/ublock_origin-1.31.0-an+fx.xpi',
#       '3679479/https_everywhere-2020.11.17-an+fx.xpi',
#       '3690660/user_agent_switcher-1.4.1-an+fx.xpi',
#       '3672658/decentraleyes-2.0.15-an+fx.xpi',
#       '3682334/clearurls-1.20.0-an+fx.xpi',
#       '3691752/noscript_security_suite-11.1.6-an+fx.xpi',
#       '3724574/grammatik_und_rechtschreibprufung_languagetool-3.3.4-fx.xpi'
#     ]
#   }
#
class workstation::multimedia::firefox (
  Array $extensions = []
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  include workstation
  include workstation::multimedia::wget

  package { 'firefox': }

  $path = "${workstation::home}/.mozilla/extensions/"

  exec { "Create ${path}":
    creates => $path,
    command => "mkdir -p ${path}",
    user  => $workstation::username
  }

  $extensions.each |String $package| {
    wget::retrieve { "Download ${package}":
      source => "https://addons.mozilla.org/firefox/downloads/file/${package}",
      destination => $path,
      timeout => 0,
      verbose => false
    }
  }
}
