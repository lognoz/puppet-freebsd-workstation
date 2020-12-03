# See LICENSE file for copyright and license details.

SHELL := /bin/sh

dependencies:
	puppet module install puppetlabs-apache
	puppet module install puppet-php
	puppet module install puppet-nodejs
	puppet module install puppetlabs-stdlib
	puppet module install puppetlabs-vcsrepo
	puppet module install puppet-archive
	puppet module install saz-timezone
	puppet module install saz-sudo

provisioning:
	set ASSUME_ALWAYS_YES = yes
	pkg update -f
	pkg install git
	pkg install puppet6

.PHONY: provisioning dependencies
