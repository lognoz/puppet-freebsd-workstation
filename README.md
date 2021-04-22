# Puppet FreeBSD Workstation

Puppet script for provisioning my FreeBSD desktop workstation.

## Table of Content
- [Setup](#setup)
- [Prerequisites](#prerequisites)
  - [System dependencies](#system-dependencies)
  - [Puppet dependencies](#puppet-dependencies)

## Setup

First, you need to get the latest source code by cloning the git repository with this command.
```
git clone https://github.com/lognoz/puppet-freebsd-workstation.git
```

Finally, change to the directory that was just created.
```
cd puppet-freebsd-workstation
```

## Prerequisites

You must be run as *root* and have an internet connection. You can install the dependencies with this command line:
```
make dependencies
```

### System dependencies

[Git](https://www.freshports.org/devel/git) <br/>
Distributed source code management tool.

[Puppet](https://www.freshports.org/sysutils/puppet6) <br/>
Configuration management framework written in Ruby.

### Puppet dependencies

[puppet-archive](https://forge.puppet.com/modules/puppet/archive) <br/>
Compressed archive file download and extraction with native types/providers for Windows and Unix.

[puppet-nodejs](https://forge.puppet.com/modules/puppet/nodejs) <br/>
Install Node.js package and npm package provider.

[puppet-php](https://forge.puppet.com/modules/puppet/php) <br/>
Generic PHP module that supports many platforms.

[puppetlabs-apache](https://forge.puppet.com/modules/puppetlabs/apache) <br/>
Installs, configures, and manages Apache virtual hosts, web services, and modules.

[puppetlabs-mysql](https://forge.puppet.com/modules/puppetlabs/mysql) <br/>
Installs, configures, and manages the MySQL service.

[puppetlabs-stdlib](https://forge.puppet.com/modules/puppetlabs/stdlib) <br/>
Standard library of resources for Puppet modules.

[puppetlabs-vcsrepo](https://forge.puppet.com/modules/puppetlabs/vcsrepo) <br/>
Puppet module providing a type to manage repositories from various version control systems.

[saz-sudo](https://forge.puppet.com/modules/saz/sudo) <br/>
Manage sudo configuration via Puppet.

[saz-timezone](https://forge.puppet.com/modules/saz/timezone) <br/>
Manage timezone settings via Puppet

[rehan-wget](https://forge.puppet.com/modules/rehan/wget) <br/>
Install, manage and configure wget and retrieve files using it.
