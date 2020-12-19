# See LICENSE file for copyright and license details.

SHELL= /bin/sh
SRC=   /usr/local/etc/puppet/modules/workstation

check-privilege:
	@if [ `whoami` != "root" ]; then \
		echo "This script must be run as root."; \
		exit 1; \
	fi

refresh:
	@if [ `pwd` != ${SRC} ]; then \
		if [ -d ${SRC} ]; then \
			rm -r ${SRC}; \
		fi; \
		cp -r `pwd` ${SRC}; \
	fi

dependencies: check-privilege
	puppet module install puppet-archive
	puppet module install puppet-nodejs
	puppet module install puppet-php
	puppet module install puppetlabs-apache
	puppet module install puppetlabs-mysql
	puppet module install puppetlabs-stdlib
	puppet module install puppetlabs-vcsrepo
	puppet module install saz-sudo
	puppet module install saz-timezone

provisioning: check-privilege
	set ASSUME_ALWAYS_YES = yes
	pkg update -f
	pkg install git
	pkg install puppet6

execute: check-privilege refresh
	puppet apply ${SRC}/example.pp

.PHONY: execute dependencies provisioning refresh
