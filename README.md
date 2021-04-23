# Puppet FreeBSD Workstation

Puppet script for provisioning my FreeBSD desktop workstation.

#### Table of content
- [Setup](#setup)
- [Prerequisites](#prerequisites)
  - [System dependencies](#system-dependencies)
  - [Puppet dependencies](#puppet-dependencies)
- [Manifests](#manifests)

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

[git](https://git-scm.com/) <br/>
Distributed source code management tool

[puppet6](https://puppet.com/docs/puppet/latest/puppet_index.html) <br/>
Configuration management framework written in Ruby

### Puppet dependencies

[puppet-archive](https://forge.puppet.com/modules/puppet/archive) <br/>
Compressed archive file download and extraction with native types/providers for Windows and Unix

[puppet-nodejs](https://forge.puppet.com/modules/puppet/nodejs) <br/>
Install Node.js package and npm package provider.

[puppet-php](https://forge.puppet.com/modules/puppet/php) <br/>
Generic PHP module that supports many platforms

[puppetlabs-apache](https://forge.puppet.com/modules/puppetlabs/apache) <br/>
Installs, configures, and manages Apache virtual hosts, web services, and modules.

[puppetlabs-mysql](https://forge.puppet.com/modules/puppetlabs/mysql) <br/>
Installs, configures, and manages the MySQL service.

[puppetlabs-stdlib](https://forge.puppet.com/modules/puppetlabs/stdlib) <br/>
Standard library of resources for Puppet modules.

[puppetlabs-vcsrepo](https://forge.puppet.com/modules/puppetlabs/vcsrepo) <br/>
Puppet module providing a type to manage repositories from various version control systems

[rehan-wget](https://forge.puppet.com/modules/rehan/wget) <br/>
Install, manage and configure wget and retrieve files using it

[saz-sudo](https://forge.puppet.com/modules/saz/sudo) <br/>
Manage sudo configuration via Puppet

[saz-timezone](https://forge.puppet.com/modules/saz/timezone) <br/>
Manage timezone settings via Puppet

## Manifests

### [workstation::powerd](manifests/powerd.pp)
  
This class initialize powerd package. This program utility monitors  
the system state and sets various power control options accordingly.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::powerd
```

</details>

### [workstation::fonts](manifests/fonts.pp)
  
This class install system fonts.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::fonts
```

</details>

### [workstation::graphic](manifests/graphic.pp)
  
This class add graphics support to make FreeBSD usable as a desktop.  
It only supports Intel HD and NVIDIA graphics cards.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*hardware*] — Type: `string` Default: `undef`  
  String used to install the right graphic card.  
  It expected to recives 'intel' or 'nvidia'.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
class { 'workstation::graphic':  
  hardware => 'nvidia'  
}
```

</details>

### [workstation::doas](manifests/doas.pp)
  
This class sets doas package. This program allows a regular user to  
run commands as another user (usually root).  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::doas
```

</details>

### [workstation::keyboard](manifests/keyboard.pp)
  
This class sets keyboard in xorg. For each input device (keyboard,  
mouse, etc.) it need an InputClass section.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*keyboard*] — Type: `string` Default: `undef`  
  String used as kbd layout.  
  
  [*remap_caps*] — Type: `boolean` Default: `true`  
  Boolean on if caps lock is replaced by escape.  
  
#### Requires:
  Class workstation::x11::xorg  
  
#### Sample Usage:
```puppet
class { 'workstation::keyboard':  
  keyboard => 'us,ca'  
}
```

</details>

### [workstation::alsamixer](manifests/alsamixer.pp)
  
This class initialize alsamixer package. This program is a graphical  
mixer program for the Advanced Linux Sound Architecture that is used  
to configure sound settings and adjust the volume.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::alsamixer
```

</details>

### [workstation::sudo](manifests/sudo.pp)
  
This class initialize sudo package. This program is designed to  
allow a sysadmin to give limited root privileges to users and log  
root activity.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::sudo
```

</details>

### [workstation::package](manifests/package.pp)
  
This class sets FreeBSD package configurations.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*prefer_yes*] — Type: `boolean` Default: `true`  
  Boolean used to make yes option the default operations  
  for dialog. Most pkg operations offer a yes/no  
  question, showing the default as a capital letter.  
  Being conservative, pkg normally defaults to no.  
  Default: true  
  
  [*autoclean*] — Type: `boolean` Default: `true`  
  Boolean used to automatically clean out the content of  
  pkg cache after each non dry-run call to 'pkg install'  
  or 'pkg upgrade'.  
  Default: true  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::package
```

</details>

### [workstation::x11:dwm](manifests/x11/dwm.pp)
  
This module manages Dynamic Windows Manager installation.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::x11:dwm
```

</details>

### [workstation::x11::xorg](manifests/x11/xorg.pp)
  
This class sets xorg package. Xorg (commonly referred as simply X)  
is the most popular display server among Linux and BSD users.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::x11::xorg
```

</details>

### [workstation::user::git](manifests/user/git.pp)
  
This class initialize git package. This program is a distributed  
version-control system for tracking changes in source code during  
software development.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*username*] — Type: `string` Default: `undef`  
  Content of git user name.  
  
  [*email*] — Type: `string` Default: `undef`  
  Content of git user email.  
  
  [*url*] — Type: `hash|undef` Default: `undef`  
  Hash of git url to be rewritten.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
class { 'workstation::user::git':  
  username  => 'Marc-Antoine Loignon',  
  email => 'developer@lognoz.org'  
  urls => {  
    'https://lognoz@github.com' => 'https://github.com',  
  }  
}
```

</details>
