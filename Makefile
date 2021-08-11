# Created by: Marc-Antoine Loignon <developer@lognoz.org>
# See LICENSE file for copyright and license details.

MAINTAINER=	developer@lognoz.org
COMMENT=	Puppet script for provisioning my FreeBSD desktop workstation

PUPPET_DIR=	/usr/local/etc/puppet/modules
SRC= ${PUPPET_DIR}/workstation

PIP= pip-3.8
PUPPET= puppet
PYTHON= python3.8
SHELL= csh

FREEBSD_PACKAGES=	git puppet7
PUPPET_PACKAGES=	puppet-archive puppet-nodejs puppet-php puppetlabs-apache puppetlabs-mysql \
						puppetlabs-stdlib puppetlabs-vcsrepo saz-sudo saz-timezone rehan-wget

ASSUME_YES= env ASSUME_ALWAYS_YES=yes


all: apply-site

dependencies: freebsd-dependencies puppet-dependencies

check-requirements: check-privilege check-internet

documentation:
	@${PYTHON} script/doc.py

attach-git-hooks:
	@cp script/bin/prepare-commit-msg .git/hooks
	@chmod +x .git/hooks/prepare-commit-msg
	@cp script/bin/commit-msg .git/hooks
	@chmod +x .git/hooks/commit-msg

apply-example-site: check-requirements refresh
	@if [ ! -f ${SRC}/example.pp ]; then \
		echo "example.pp not found!"; \
		exit 1; \
	fi
	@puppet apply --modulepath=${PUPPET_DIR} ${SRC}/example.pp

apply-site: check-requirements refresh
	@if [ ! -f ${SRC}/site.pp ]; then \
		echo "site.pp not found!"; \
		exit 1; \
	fi
	@puppet apply --modulepath=${PUPPET_DIR} ${SRC}/site.pp

refresh:
	@if [ `pwd` != ${SRC} ]; then \
		if [ -d ${SRC} ]; then \
			rm -r ${SRC}; \
		fi; \
		cp -r `pwd` ${SRC}; \
	fi

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


.PHONY: all dependencies documentation check-requirements check-internet check-privilege refresh \
        puppet-dependencies freebsd-dependencies python-dependencies apply-example-site apply-site
