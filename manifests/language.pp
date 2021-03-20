# Class: workstation::language
#
# Parameters:
#   [*aspell*]
#     Array of languages to install via Freebsd ports. Make sure
#     to have the right package name before to call this class.
#     Default: undef
#
# Sample Usage:
#   class { 'workstation::language':
#     aspell => ['en','fr']
#   }
#
class workstation::language (
  Array $aspell = undef,
  String $directory = "/.share"
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
  }

  $share_directory = "/home/${workstation::username}/${directory}"

  # Install package to translates acronyms for you.
  package { 'wtf': }

  # Install grammar and spell checker.
  package { [
    'aspell-ispell',
    'openjdk8-jre'
  ]: }

  $aspell.each |String $language| {
    package { "${language}-aspell": }
  }

  file { "${share_directory}":
    ensure => directory
  }

  exec { 'Install Language Tool package':
    cwd => $share_directory,
    unless => "[ -d ${share_directory}/language-tool ]",
    command => "curl -L https://raw.githubusercontent.com/languagetool-org/languagetool/master/install.sh | bash",
  }

  exec { 'Rename Language Tool directory':
    cwd => $share_directory,
    unless => "[ -d ${share_directory}/language-tool ]",
    command => "mv ${share_directory}/LanguageTool* ${share_directory}/language-tool",
  }
}
