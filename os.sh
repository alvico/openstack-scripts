#!/bin/bash

if [[ $# < 1 ]]; then
  echo "usage: $0 [stop|start|restart] [service]"
  exit
fi

SERVICE=${2:-"all"}

if [[ $SERVICE == "keystone" || $SERVICE == "all" ]]; then
  service keystone $1
fi

if [[ $SERVICE == "glance" || $SERVICE == "all" ]]; then
  service glance-api $1
  service glance-registry $1
fi

if [[ $SERVICE == "nova" || $SERVICE == "all" ]]; then
  service nova-api $1
  service nova-cert $1
  service nova-consoleauth $1
  service nova-scheduler $1
  service nova-conductor $1
  service nova-novncproxy $1
  service nova-compute $1
fi

if [[ $SERVICE == "neutron" || $SERVICE == "all" ]]; then
  service neutron-server $1
  service neutron-metadata-agent $1
  service neutron-dhcp-agent $1
  service neutron-l3-agent $1
  service neutron-plugin-openvswitch-agent $1
fi

if [[ $SERVICE == "openvswitch" || $SERVICE == "all" ]]; then
  service openvswitch-switch $1
fi
