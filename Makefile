# Created by: Marc-Antoine Loignon <developer@lognoz.org>
# See LICENSE file for copyright and license details.

MAINTAINER=	developer@lognoz.org
COMMENT=	Puppet script for provisioning my FreeBSD desktop workstation

PUPPET_DIR=	/usr/local/etc/puppet/modules
SRC=	${PUPPET_DIR}/workstation

PIP= pip-3.7
PUPPET= puppet
PYTHON= python3.7

FREEBSD_PACKAGES=	git puppet6
PUPPET_PACKAGES=	puppet-archive puppet-nodejs puppet-php puppetlabs-apache puppetlabs-mysql \
						puppetlabs-stdlib puppetlabs-vcsrepo saz-sudo saz-timezone rehan-wget

ASSUME_YES= env ASSUME_ALWAYS_YES=yes


all: execute

dependencies: freebsd-dependencies puppet-dependencies

documentation:
	@${PYTHON} script/doc.py

execute: check-requirements refresh
	@puppet apply --modulepath=${PUPPET_DIR} ${SRC}/example.pp

refresh:
	@if [ `pwd` != ${SRC} ]; then \
		if [ -d ${SRC} ]; then \
			rm -r ${SRC}; \
		fi; \
		cp -r `pwd` ${SRC}; \
	fi

check-requirements: check-privilege check-internet

check-internet:
	@if ! nc -zw1 fsf.org 443 > /dev/null 2>&1; then \
		echo "This script must be run with internet connection."; \
		exit 1; \
	fi \

check-privilege:
	@if [ `whoami` != "root" ]; then \
		echo "This script must be run as root."; \
		exit 1; \
	fi

puppet-dependencies: check-privilege check-internet
	@for package in ${PUPPET_PACKAGES} ; do \
		puppet module install $${package} ; \
	done

freebsd-dependencies: check-privilege check-internet
	@${ASSUME_YES} pkg bootstrap -f
	@for package in ${FREEBSD_PACKAGES} ; do \
		${ASSUME_YES} pkg install -f $${package} ; \
	done

python-dependencies:
	@${PIP} install -r ./script/requirements.txt


.PHONY: all dependencies check-requirements check-internet check-privilege refresh \
        puppet-dependencies freebsd-dependencies python-dependencies execute documentation
