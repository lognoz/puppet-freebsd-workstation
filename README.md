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

### [workstation::gnu](manifests/gnu.pp)
  
This class install GNU utils and libraries like *gmake*, *ripgrep*,  
*gls*, *gcc*, etc.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::gnu
```

</details>

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

### [workstation::optimization](manifests/optimization.pp)
  
This class install some programs and change system configurations to  
make FreeBSD usable as a desktop station.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::optimization
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

### [workstation::security](manifests/security.pp)
  
This class install improve the system security.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::security
```

</details>

### [workstation::system](manifests/system.pp)
  
This module manages system configurations.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*path*] — Type: `string` Default: `undef`  
  String use as path location to add content.  
  
  [*content*] — Type: `array` Default: `undef`  
  List of lines to add to the path location.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
workstation::system { 'Optimize boot loader':  
  path => '/boot/loader.conf',  
  content => [  
    # Change boot time kernel tuning.  
    'kern.ipc.shmseg = 1024',  
    'kern.ipc.shmmni = 1024',  
    'kern.maxproc = 100000',  
  
    # Configuring asynchronous I/O.  
    'aio_load = "YES"',  
  
    # Enable thermal sensors.  
    'coretemp_load="YES"'  
  ]  
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

### [workstation::bash::rc](manifests/bash/rc.pp)
  
This module manages bashrc configurations.  
  
Parameters:  
  [*content*]  
    Content of configuration to append.  
    Default: $title  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
workstation::bash::rc {  
  'alias ls="ls -F"'  
}
```

</details>

### [workstation::bash::alias](manifests/bash/alias.pp)
  
This module manages bash aliases configurations.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*content*] — Type: `string|array` Default: `$title`  
  Content of configuration to append.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
workstation::bash::alias { [  
  'ls="ls -F"',  
  'll="ls -lah"',  
  'emacs="emacs --maximized"'  
]: }
```

</details>

### [workstation::bash::init](manifests/bash/init.pp)
  
This class install bash and some useful configurations.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*files*] — Array: `array` Default: `[]`  
  List of files related to bash that need to be created.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::bash::init
```

</details>

### [workstation::x11:conf](manifests/x11/conf.pp)
  
This module manages Xorg configurations.  
  
Parameters:  
  [*content*]  
    Content of configuration to append.  
    Default: $title  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
workstation::x11::conf {  
  'xmodmap ~/.Xmodmap'  
}
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

### [workstation::user:emacs](manifests/user/emacs.pp)
  
This class initialize Emacs package. This program is a highly  
customizable editor indeed, it has been customized to the point  
where it is more like an operating system than an editor!  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*source*] — Type: `string` Default: `undef`  
  The git repository of Emacs configuration.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
class { 'workstation::user::emacs':  
  source => 'https://github.com/lognoz/embla'  
}
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

### [workstation::user::directories](manifests/user/directories.pp)
  
This class manages custom directories and xdg-user-dirs, a tool to  
help manage well known user directories like the desktop folder and  
the music folder.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*desktop*] — Type: `string` Default: `/`  
  The desktop user directory  
  
  [*document*] — Type: `string` Default: `/document`  
  The document user directory  
  
  [*download*] — Type: `string` Default: `/download`  
  The download user directory  
  
  [*music*] — Type: `string` Default: `/music`  
  The music user directory  
  
  [*picture*] — Type: `string` Default: `/picture`  
  The picture user directory  
  
  [*public*] — Type: `string` Default: `/public`  
  The public user directory  
  
  [*template*] — Type: `string` Default: `/template`  
  The template user directory  
  
  [*video*] — Type: `string` Default: `/video`  
  The video user directory  
  
  [*directories*] — Type: `array` Default: `[]`  
  The list of directories that need to be created  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
class { 'workstation::user::directories':  
  download => '/download/browser',  
  directories => [  
    '/download',  
    '/document',  
    '/program',  
    '/video'  
  ]  
}
```

</details>

### [workstation::multimedia::torrent](manifests/multimedia/torrent.pp)
  
This class initialize transmission package. This program is a lightweight,  
command-line BitTorrent client with scripting capabilities.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*directory*] — Type: `string` Default: `download`  
  String used as download directory for torrent file.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
class { 'workstation::multimedia::torrent':  
  directory => 'download/torrent'  
}
```

</details>

### [workstation::multimedia::firefox](manifests/multimedia/firefox.pp)
  
This class initialize Firefox package. This program, also known as  
Mozilla Firefox, is a free and open-source web browser developed by  
the Mozilla Foundation and its subsidiary, the Mozilla Corporation.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*extensions*] — Type: `array` Default: `[]`  
  List of extensions that you want to install in Firefox.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
class { 'workstation::multimedia::firefox':  
  extensions => [  
    '3679754/ublock_origin-1.31.0-an+fx.xpi',  
    '3679479/https_everywhere-2020.11.17-an+fx.xpi',  
    '3690660/user_agent_switcher-1.4.1-an+fx.xpi',  
    '3672658/decentraleyes-2.0.15-an+fx.xpi',  
    '3682334/clearurls-1.20.0-an+fx.xpi',  
    '3691752/noscript_security_suite-11.1.6-an+fx.xpi',  
    '3724574/grammatik_und_rechtschreibprufung_languagetool-3.3.4-fx.xpi'  
  ]  
}
```

</details>

### [workstation::multimedia::youtube_dl](manifests/multimedia/youtube_dl.pp)
  
This class initialize youtube-dl package. This program is an  
open-source download manager for video and audio from YouTube and  
over 1000 other video hosting websites.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*directory*] — Type: `string` Default: `video`  
  String used as download directory for torrent file.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
class { 'workstation::multimedia::youtube_dl':  
  directory => 'video/youtube'  
}
```

</details>

### [workstation::multimedia::graphic](manifests/multimedia/graphic.pp)
  
This class install *Gimp*, *Blender*, *VLC* and others useful  
graphic tools.  
  
<details><summary><i>Show detail</i></summary>

#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
include workstation::multimedia:graphic
```

</details>

### [workstation::multimedia::wget](manifests/multimedia/wget.pp)
  
This initialize wget package. This computer program that retrieves  
content from web servers.  
  
<details><summary><i>Show detail</i></summary>

#### Variables:
  [*directory*] — Type: `string` Default: `download`  
  String used as download directory for torrent file.  
  
#### Requires:
  Class workstation  
  
#### Sample Usage:
```puppet
class { 'workstation::multimedia::wget':  
  directory => 'download/wget'  
}
```

</details>


