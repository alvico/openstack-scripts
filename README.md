# OpenStack Scripts #
Growing collection of scripts I often use to either manage or test OpenStack installations with. They may not be right for exactly what you are doing, so please feel free to modify them and submit back any changes/improvements you have made.

## Installation ##
To install these scripts, use the following commands:

`git clone https://github.com/nextrevision/openstack-scripts`

Or for a single script:

`wget https://raw.github.com/nextrevision/openstack-scripts/master/scriptname.sh`

Add to a path on your OpenStack server (/usr/local/bin in this example):

`install -o root -g root -m 755 os.sh /usr/local/bin/os`

- - -
## os.sh ##
Quick and dirty little script to restart all or some openstack services. Currently configured with `keystone`, `glance`, `nova`, `neutron`, and `cinder`.

### Usage ###
Restarting all services:

`os restart`

Restarting a single service:

`os restart keystone`

Stopping a service:

`os stop glance`

Starting a service:

`os start neutron`

### To-Do ###
* Add role based restarts (controller, network, compute, storage)
* Include further OpenStack services
* Chain multiple services together (i.e. `os restart nova,neutron`)

- - -
## verbug.sh ##
Script utilizing `sed` to set verbose and debug flags to either True or False in the various OpenStack configuration files.

### Usage ###
Turn on debugging and verbose logging for all services:

`verbug on`

The opposite:

`verbug off`

Turning on for a single service:

`verbug on nova`

The opposite:

`verbug off nova`

### To-Do ###
* Add role based toggling (controller, network, compute, storge)
* Include further OpenStack services
* Chain multiple services together (i.e. `verbug off nova,neutron`)
* Optional only debug/verbose toggling?

