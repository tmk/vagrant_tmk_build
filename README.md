Vagrant VirtualBox for tmk build
================================
2016/08/08

Make ubuntu enviroment on VirtualBox to compile tmk_firmware codes and program microcontroller.


TODO
----
### Install Kinetis bootloader tool: blhost
- http://www.nxp.com/products/microcontrollers-and-processors/arm-processors/kinetis-cortex-m-mcus/kinetis-symbols-footprints-and-models/kinetis-bootloader:KBOOT

### Share holder setup
Provides access to tmk_keyboard codes and binary from Windows Explorer.


Requirement
-----------
You will need Linux flavor host machine to setup virtual machine with this Vagrantfile(due to shell provisioner).

On ubuntu host:

    $ sudo apt-get install virtualbox virtualbox-ext-pack
    $ sudo apt-get install vagrant

Or download and install them from:
- https://www.virtualbox.org/wiki/Downloads
- https://www.vagrantup.com/downloads.html

Virtualbox extension pack is needed for USB support and it can be installed from menu: `File>Preferences>Extensions`.


Usage
-----
After install of Vagrant and VirtualBox and run vagrant commands. This makes vritual machine setup and started automatically.

    $ vagrant up

Then log into the VM with ssh.

    $ vagrant ssh

See for the vagrant commands.

- https://www.vagrantup.com/


You can also use ssh client direclty with IP address `127.0.0.1` and port `2222`.  Or login from console in VirtualBox window if you want.

Use user name `ubuntu` and passowrd `ubuntu` to login the system.


Vagrant memo
------------
### Initialize

    $ vagrant box add ubuntu/xenial64
    $ vagrant init
    $ vi Vagrant
        ...
        config.vm.box = "ubuntu/xenial64"
        ...


### Vagrantfile
- https://www.vagrantup.com/docs/provisioning/shell.html
- https://www.vagrantup.com/docs/vagrantfile/ssh_settings.html


### Installed files under home directory
```
$ tree ~/.vagrant.d/
/home/noname/.vagrant.d/
├── boxes
│   └── ubuntu-VAGRANTSLASH-xenial64
│       ├── 20160805.0.0
│       │   └── virtualbox
│       │       ├── box.ovf
│       │       ├── metadata.json
│       │       ├── ubuntu-xenial-16.04-cloudimg-configdrive.vmdk
│       │       ├── ubuntu-xenial-16.04-cloudimg.mf
│       │       ├── ubuntu-xenial-16.04-cloudimg.vmdk
│       │       └── Vagrantfile
│       └── metadata_url
├── data
│   ├── lock.dotlock.lock
│   ├── lock.machine-action-b3231367d29fac6479955d221344bca3.lock
│   └── machine-index
│       └── index.lock
├── gems
│   └── ruby
│       └── 2.3.0
├── insecure_private_key
├── rgloader
│   └── loader.rb
├── setup_version
└── tmp

11 directories, 13 files
```
