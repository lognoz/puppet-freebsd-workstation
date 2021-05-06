# Puppet FreeBSD Workstation

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

Puppet script for provisioning my FreeBSD desktop workstation.

<img align="right" width="300" src="./script/daemon.jpg">

#### Table of Contents
- [Setup](#setup)
- [Prerequisites](#prerequisites)
  - [System dependencies](#system-dependencies)
  - [Puppet dependencies](#puppet-dependencies)
- [Usage](#usage)
- [Manifests](#manifests)
- [Limitations](#limitations)

<br/>

## Setup

First, you need to get the latest source code by cloning the git repository with this command.
```
git clone https://github.com/lognoz/puppet-freebsd-workstation.git
```

Finally, change to the directory that was just created.
```
cd puppet-freebsd-workstation
```

<br/>

## Prerequisites

You must be run as *root* and have an internet connection. You can install the dependencies with this command line:
```
make dependencies
```

### System dependencies

[system-dependencies]

### Puppet dependencies

[puppet-dependencies]

<br/>

## Usage

Create your own `site.pp` at base path:
```
touch site.pp
```

You can read `example.pp` located to base path to help building your own site node.  
Add to your file the user that will lead your workstation: 

```puppet
class { 'workstation':
  username => 'john',
  owner_name => 'John Doe',
  owner_email => 'developer@john-doe.org',
  timezone => 'America/New_York',
  password => 'default'
}
```

Finally, apply your site file by executing this command. Be carful this will replace directory  
located at `/usr/local/etc/puppet/modules/workstation/`.
```
make
```

<br/>

## Manifests

#### List of available manifests
[manifests-table-of-contents]

<br/>

[manifests-content]

<br/>

## Limitations

This module is only usable with FreeBSD.
