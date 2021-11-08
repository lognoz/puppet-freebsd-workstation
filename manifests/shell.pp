# Class: workstation::shell
#
# This class install shell and some useful configurations.
#
# Variables:
#   `files` — Type: *array* — Default: *[]*
#   List of files related to shell that need to be created.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::shell
#
class workstation::shell (
  String $processor = undef
) {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  }

  if $processor =~ /\/bash$/ {
    package { [
      'bash',
      'bash-completion'
    ]: }

    $rc = '.bashrc'
  }
  elsif ($processor =~ /\/zsh$/) {
    package { [
      'zsh',
      'zsh-completions'
    ]: }

    $rc = '.zshrc'
  }
  else {
    fail("Parameter processor '${processor}' is not supported.")
  }

  $files = [ $rc, '.aliases' ]

  exec { 'Change permanently the default shell':
    command => "chsh -s ${processor}"
  }

  $files.each |String $filename| {
    file { "/${workstation::home}/${filename}":
      ensure => present,
      owner => $workstation::username,
      group => $workstation::username,
      mode  => '0755'
    }
  }

  workstation::shell::rc { [
      'export PATH="$PATH:$(find ~/.local/bin -type d | xargs printf \'%s:\')"',
      '[ -r ~/.aliases ] && [ -f ~/.aliases ] && source ~/.aliases'
  ]: }
}
