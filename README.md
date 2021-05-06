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
- [workstation](#workstation)
- [workstation::alsamixer](#workstationalsamixer)
- [workstation::bash::alias](#workstationbashalias)
- [workstation::bash::init](#workstationbashinit)
- [workstation::bash::rc](#workstationbashrc)
- [workstation::doas](#workstationdoas)
- [workstation::fonts](#workstationfonts)
- [workstation::gnu](#workstationgnu)
- [workstation::graphic](#workstationgraphic)
- [workstation::keyboard](#workstationkeyboard)
- [workstation::language](#workstationlanguage)
- [workstation::multimedia::firefox](#workstationmultimediafirefox)
- [workstation::multimedia::graphic](#workstationmultimediagraphic)
- [workstation::multimedia::torrent](#workstationmultimediatorrent)
- [workstation::multimedia::wget](#workstationmultimediawget)
- [workstation::multimedia::youtube_dl](#workstationmultimediayoutube_dl)
- [workstation::optimization](#workstationoptimization)
- [workstation::package](#workstationpackage)
- [workstation::powerd](#workstationpowerd)
- [workstation::programming::hacking](#workstationprogramminghacking)
- [workstation::programming::latex](#workstationprogramminglatex)
- [workstation::programming::lisp::clisp](#workstationprogramminglispclisp)
- [workstation::programming::python](#workstationprogrammingpython)
- [workstation::programming::virtualisation](#workstationprogrammingvirtualisation)
- [workstation::programming::web::apache](#workstationprogrammingwebapache)
- [workstation::programming::web::mysql](#workstationprogrammingwebmysql)
- [workstation::programming::web::npm](#workstationprogrammingwebnpm)
- [workstation::programming::web::php](#workstationprogrammingwebphp)
- [workstation::security](#workstationsecurity)
- [workstation::sudo](#workstationsudo)
- [workstation::system](#workstationsystem)
- [workstation::user::directories](#workstationuserdirectories)
- [workstation::user::emacs](#workstationuseremacs)
- [workstation::user::git](#workstationusergit)
- [workstation::user::vim](#workstationuservim)
- [workstation::x11::conf](#workstationx11conf)
- [workstation::x11::dwm](#workstationx11dwm)
- [workstation::x11::xorg](#workstationx11xorg)


<br/>

### [workstation](manifests/init.pp)

This class sets root and user for FreeBSD systems. Make sure to load  
this file before any workstation subclasses.  

<details><summary>Show detail</summary>

#### Variables:
  `username` — Type: *string* — Default: *undef*  
  String used to create user and its home directory.  

  `password` — Type: *string* — Default: *undef*  
  String used as user and root password.  

  `timezone` — Type: *string* — Default: *undef*  
  String used as timezone reference.  

  `owner_name` — Type: *string* — Default: *undef*  
  String used as computer owner name.  

  `owner_email` — Type: *string* — Default: *undef*  
  String used as computer owner email.  

  `shell` — Type: *string|undef* — Default: *undef*  
  String used as command processor path. If you use zsh on FreeBSD,  
  you will send /usr/bin/zsh. By default, this class will install  
  and use bash if $shell is undefined.  

  `root` — Type: *string* — Default: */usr/local/etc/puppet/modules/workstation/*  
  The reference on where the workstation module is located.  

#### Sample Usage:
```puppet
class { 'workstation':  
  username => 'lognoz',  
  owner_name => 'Marc-Antoine Loignon',  
  owner_email => 'developer@lognoz.org',  
  timezone => 'America/New_York',  
  password => $password  
}
```

<br/>

</details>

### [workstation::alsamixer](manifests/alsamixer.pp)

This class initialize alsamixer package. This program is a graphical  
mixer program for the Advanced Linux Sound Architecture that is used  
to configure sound settings and adjust the volume.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::alsamixer
```

<br/>

</details>

### [workstation::bash::alias](manifests/bash/alias.pp)

This module manages bash aliases configurations.  

<details><summary>Show detail</summary>

#### Variables:
  `content` — Type: *string|array* — Default: *$title*  
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

<br/>

</details>

### [workstation::bash::init](manifests/bash/init.pp)

This class install bash and some useful configurations.  

<details><summary>Show detail</summary>

#### Variables:
  `files` — Type: *array* — Default: *[]*  
  List of files related to bash that need to be created.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::bash::init
```

<br/>

</details>

### [workstation::bash::rc](manifests/bash/rc.pp)

This module manages bashrc configurations.  

<details><summary>Show detail</summary>

#### Variables:
  `content` — Type: *string|array* — Default: *$title*  
  Content of configuration to append.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
workstation::bash::rc {  
  'alias ls="ls -F"':  
}
```

<br/>

</details>

### [workstation::doas](manifests/doas.pp)

This class sets doas package. This program allows a regular user to  
run commands as another user (usually root).  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::doas
```

<br/>

</details>

### [workstation::fonts](manifests/fonts.pp)

This class install system fonts.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::fonts
```

<br/>

</details>

### [workstation::gnu](manifests/gnu.pp)

This class install GNU utils and libraries like *gmake*, *ripgrep*,  
*gls*, *gcc*, etc.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::gnu
```

<br/>

</details>

### [workstation::graphic](manifests/graphic.pp)

This class add graphics support to make FreeBSD usable as a desktop.  
It only supports Intel HD and NVIDIA graphics cards.  

<details><summary>Show detail</summary>

#### Variables:
  `hardware` — Type: *string* — Default: *undef*  
  String used to install the right graphic card.  
  It expected to recives *intel* or *nvidia*.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
class { 'workstation::graphic':  
  hardware => 'nvidia'  
}
```

<br/>

</details>

### [workstation::keyboard](manifests/keyboard.pp)

This class sets keyboard in xorg. For each input device (keyboard,  
mouse, etc.) it need an InputClass section.  

<details><summary>Show detail</summary>

#### Variables:
  `keyboard` — Type: *string* — Default: *undef*  
  String used as kbd layout.  

  `remap_caps` — Type: *boolean* — Default: *true*  
  Boolean on if caps lock is replaced by escape.  

#### Requires:
  Class workstation::x11::xorg  

#### Sample Usage:
```puppet
class { 'workstation::keyboard':  
  keyboard => 'us,ca'  
}
```

<br/>

</details>

### [workstation::language](manifests/language.pp)

This class help to manage multiple languages keyboard and language  
tool program.  

<details><summary>Show detail</summary>

#### Variables:
  `aspell` — Type: *string* — Default: *undef*  
  Array of languages to install via Freebsd ports. Make sure  
  to have the right package name before to call this class.  

  `directory` — Type: *string* — Default: *~/.share*  
  The location on where to install Language Tool package.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
class { 'workstation::language':  
  aspell => ['en','fr']  
}
```

<br/>

</details>

### [workstation::multimedia::firefox](manifests/multimedia/firefox.pp)

This class initialize Firefox package. This program, also known as  
Mozilla Firefox, is a free and open-source web browser developed by  
the Mozilla Foundation and its subsidiary, the Mozilla Corporation.  

<details><summary>Show detail</summary>

#### Variables:
  `extensions` — Type: *array* — Default: *[]*  
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

<br/>

</details>

### [workstation::multimedia::graphic](manifests/multimedia/graphic.pp)

This class install *Gimp*, *Blender*, *VLC* and others useful  
graphic tools.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::multimedia:graphic
```

<br/>

</details>

### [workstation::multimedia::torrent](manifests/multimedia/torrent.pp)

This class initialize transmission package. This program is a lightweight,  
command-line BitTorrent client with scripting capabilities.  

<details><summary>Show detail</summary>

#### Variables:
  `directory` — Type: *string* — Default: *download*  
  String used as download directory for torrent file.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
class { 'workstation::multimedia::torrent':  
  directory => 'download/torrent'  
}
```

<br/>

</details>

### [workstation::multimedia::wget](manifests/multimedia/wget.pp)

This initialize wget package. This computer program that retrieves  
content from web servers.  

<details><summary>Show detail</summary>

#### Variables:
  `directory` — Type: *string* — Default: *download*  
  String used as download directory for torrent file.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
class { 'workstation::multimedia::wget':  
  directory => 'download/wget'  
}
```

<br/>

</details>

### [workstation::multimedia::youtube_dl](manifests/multimedia/youtube_dl.pp)

This class initialize youtube-dl package. This program is an  
open-source download manager for video and audio from YouTube and  
over 1000 other video hosting websites.  

<details><summary>Show detail</summary>

#### Variables:
  `directory` — Type: *string* — Default: *video*  
  String used as download directory for torrent file.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
class { 'workstation::multimedia::youtube_dl':  
  directory => 'video/youtube'  
}
```

<br/>

</details>

### [workstation::optimization](manifests/optimization.pp)

This class install some programs and change system configurations to  
make FreeBSD usable as a desktop station.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::optimization
```

<br/>

</details>

### [workstation::package](manifests/package.pp)

This class sets FreeBSD package configurations.  

<details><summary>Show detail</summary>

#### Variables:
  `prefer_yes` — Type: *boolean* — Default: *true*  
  Boolean used to make yes option the default operations  
  for dialog. Most pkg operations offer a yes/no  
  question, showing the default as a capital letter.  
  Being conservative, pkg normally defaults to no.  

  `autoclean` — Type: *boolean* — Default: *true*  
  Boolean used to automatically clean out the content of  
  pkg cache after each non dry-run call to *pkg install*  
  or *pkg upgrade*.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::package
```

<br/>

</details>

### [workstation::powerd](manifests/powerd.pp)

This class initialize powerd package. This program utility monitors  
the system state and sets various power control options accordingly.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::powerd
```

<br/>

</details>

### [workstation::programming::hacking](manifests/programming/hacking.pp)

This class install most useful hacking tools.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::programming::hacking
```

<br/>

</details>

### [workstation::programming::latex](manifests/programming/latex.pp)

This class initialize LaTeX programming language.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::programming::latex
```

<br/>

</details>

### [workstation::programming::lisp::clisp](manifests/programming/lisp/clisp.pp)

This class initialize Common Lisp programming language.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::programming::lisp::clisp
```

<br/>

</details>

### [workstation::programming::python](manifests/programming/python.pp)

This class initialize Python programming language.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::programming::python
```

<br/>

</details>

### [workstation::programming::virtualisation](manifests/programming/virtualisation.pp)

This class initialize virtualisation program like *Vagrant*,  
*Docker* and *Virtualbox*.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::programming:virtualisation
```

<br/>

</details>

### [workstation::programming::web::apache](manifests/programming/web/apache.pp)

This class initialize Apache server.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::programming::web:apache
```

<br/>

</details>

### [workstation::programming::web::mysql](manifests/programming/web/mysql.pp)

This class initialize MySQL database server.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::programming::web:mysql
```

<br/>

</details>

### [workstation::programming::web::npm](manifests/programming/web/npm.pp)

This class initialize npm package. This program is a package manager  
for the JavaScript programming language.  

<details><summary>Show detail</summary>

#### Variables:
  `packages` — Type: *array* — Default: *undef*  
  List of packages to be install globally.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::programming::web:npm
```

<br/>

</details>

### [workstation::programming::web::php](manifests/programming/web/php.pp)

This class initialize PHP programming language.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::programming::web:php
```

<br/>

</details>

### [workstation::security](manifests/security.pp)

This class install improve the system security.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::security
```

<br/>

</details>

### [workstation::sudo](manifests/sudo.pp)

This class initialize sudo package. This program is designed to  
allow a sysadmin to give limited root privileges to users and log  
root activity.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::sudo
```

<br/>

</details>

### [workstation::system](manifests/system.pp)

This module manages system configurations.  

<details><summary>Show detail</summary>

#### Variables:
  `path` — Type: *string* — Default: *undef*  
  String use as path location to add content.  

  `content` — Type: *array* — Default: *undef*  
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

<br/>

</details>

### [workstation::user::directories](manifests/user/directories.pp)

This class manages custom directories and xdg-user-dirs, a tool to  
help manage well known user directories like the desktop folder and  
the music folder.  

<details><summary>Show detail</summary>

#### Variables:
  `desktop` — Type: *string* — Default: */*  
  The desktop user directory  

  `document` — Type: *string* — Default: */document*  
  The document user directory  

  `download` — Type: *string* — Default: */download*  
  The download user directory  

  `music` — Type: *string* — Default: */music*  
  The music user directory  

  `picture` — Type: *string* — Default: */picture*  
  The picture user directory  

  `public` — Type: *string* — Default: */public*  
  The public user directory  

  `template` — Type: *string* — Default: */template*  
  The template user directory  

  `video` — Type: *string* — Default: */video*  
  The video user directory  

  `directories` — Type: *array* — Default: *[]*  
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

<br/>

</details>

### [workstation::user::emacs](manifests/user/emacs.pp)

This class initialize Emacs package. This program is a highly  
customizable editor indeed, it has been customized to the point  
where it is more like an operating system than an editor!  

<details><summary>Show detail</summary>

#### Variables:
  `source` — Type: *string* — Default: *undef*  
  The git repository of Emacs configuration.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
class { 'workstation::user::emacs':  
  source => 'https://github.com/lognoz/embla'  
}
```

<br/>

</details>

### [workstation::user::git](manifests/user/git.pp)

This class initialize git package. This program is a distributed  
version-control system for tracking changes in source code during  
software development.  

<details><summary>Show detail</summary>

#### Variables:
  `username` — Type: *string* — Default: *undef*  
  Content of git user name.  

  `email` — Type: *string* — Default: *undef*  
  Content of git user email.  

  `url` — Type: *hash|undef* — Default: *undef*  
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

<br/>

</details>

### [workstation::user::vim](manifests/user/vim.pp)

This class initialize Vim package. This program is a highly  
configurable text editor built to make creating and changing any  
kind of text very efficient.  

<details><summary>Show detail</summary>

#### Variables:
  `source` — Type: *string* — Default: *undef*  
  The git repository of vim configuration.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
class { 'workstation::user::vim':  
  source => 'https://github.com/lognoz/vimrc'  
}
```

<br/>

</details>

### [workstation::x11::conf](manifests/x11/conf.pp)

This module manages Xorg configurations.  

<details><summary>Show detail</summary>

#### Variables:
  `content` — Type: *string|array* — Default: *$title*  
  Content of configuration to append to xinitrc.  

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
workstation::x11::conf {  
  'xmodmap ~/.Xmodmap':  
}
```

<br/>

</details>

### [workstation::x11::dwm](manifests/x11/dwm.pp)

This module manages Dynamic Windows Manager installation.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::x11:dwm
```

<br/>

</details>

### [workstation::x11::xorg](manifests/x11/xorg.pp)

This class sets xorg package. Xorg (commonly referred as simply X)  
is the most popular display server among Linux and BSD users.  

<details><summary>Show detail</summary>

#### Requires:
  Class workstation  

#### Sample Usage:
```puppet
include workstation::x11::xorg
```

</details>

<br/>

## Limitations

This module is only usable with FreeBSD.
