# Puppet FreeBSD Workstation

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

Puppet script for provisioning my FreeBSD desktop workstation.

<img align="right" width="300" src="./script/daemon.jpg">

#### Table of Contents
- [Setup](#setup)
- [Prerequisites](#prerequisites)
  - [System dependencies](#system-dependencies)
  - [Puppet dependencies](#puppet-dependencies)
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

## Manifests

#### List of available manifests
[manifests-table-of-contents]

<br/>

[manifests-content]

<br/>

## Limitations

This module is only usable with FreeBSD.
