#!/bin/bash

# config locations
KEYSTONE_CONF=/etc/keystone/keystone.conf
GLANCE_API_CONF=/etc/glance/glance-api.conf
GLANCE_REGISTRY_CONF=/etc/glance/glance-registry.conf
NOVA_CONF=/etc/nova/nova.conf
NEUTRON_CONF=/etc/neutron/neutron.conf

usage() {
  echo "usage: $0 [on|off] [service (optional)]"
}

# at least one param must be given
if [[ $# < 1 ]]; then
  usage
  exit 1
fi

TOGGLE=$1
SERVICE=${2:-"all"}

SED=$(which sed || echo "/bin/sed")
OS=$(which os || echo "/usr/local/bin/os")

# make sure sed is available to this user
if ! test -x $SED; then
  echo "Cannot find 'sed'; Ensure it is installed and in your \$PATH"
  exit 1
fi

# translate toggle to True or False
if [[ $TOGGLE == "on" ]]; then
  TOGGLE="True"
elif [[ $TOGGLE == "off" ]]; then
  TOGGLE="False"
else
  usage
  exit 1
fi

# actual string being used by sed
DEBUG_STR="s/^([\# ]+)?debug([ ]+)?=([ ]+)?(true|false)$/debug=${TOGGLE}/Ig"
VERBOSE_STR="s/^([\# ]+)?verbose([ ]+)?=([ ]+)?(true|false)$/verbose=${TOGGLE}/Ig"

if [[ $SERVICE == "keystone" || $SERVICE == "all" ]]; then
  $SED -r -i "${DEBUG_STR}" $KEYSTONE_CONF
  $SED -r -i "${VERBOSE_STR}" $KEYSTONE_CONF
fi

if [[ $SERVICE == "glance" || $SERVICE == "all" ]]; then
  $SED -r -i "${DEBUG_STR}" $GLANCE_API_CONF
  $SED -r -i "${DEBUG_STR}" $GLANCE_REGISTRY_CONF
  $SED -r -i "${VERBOSE_STR}" $GLANCE_API_CONF
  $SED -r -i "${VERBOSE_STR}" $GLANCE_REGISTRY_CONF
fi

if [[ $SERVICE == "nova" || $SERVICE == "all" ]]; then
  $SED -r -i "${DEBUG_STR}" $NOVA_CONF
  $SED -r -i "${VERBOSE_STR}" $NOVA_CONF
fi

if [[ $SERVICE == "neutron" || $SERVICE == "all" ]]; then
  $SED -r -i "${DEBUG_STR}" $NEUTRON_CONF
  $SED -r -i "${VERBOSE_STR}" $NEUTRON_CONF
fi

echo "Finished: service[s] needing restarted: ${SERVICE}"

if test -x $OS; then
  read -p "I found the os restart script, want me to restart ${SERVICE}? [y/n] "
  if [[ $REPLY == 'y' ]]; then
    $OS restart $SERVICE
  fi
fi
