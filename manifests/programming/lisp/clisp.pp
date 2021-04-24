# Class: workstation::programming::lisp::clisp
#
# This class initialize Common Lisp programming language.
#
# Requires:
#   Class workstation
#
# Sample Usage:
#   include workstation::programming::lisp::clisp
#
class workstation::programming::lisp::clisp {
  # Make sure this subclass is executed after workstation is loaded.
  if ! defined(Class['workstation']) {
    fail('You must include the base workstation class before using any subclasses.')
  } else {
    include workstation
  }

  package { [
    'clisp',
    'clisp-hyperspec'
  ]: }
}
