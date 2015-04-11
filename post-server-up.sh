#!/bin/bash

if [ `whoami` != 'root' ]; then
    exit 1
fi

subnet=$(netmask ${ifconfig_local}/${ifconfig_netmask} | awk '{print $1;}')
ip route replace $subnet via $ifconfig_local dev $dev table 1002

subnet6=$(ip -6 addr show dev $dev | grep inet6 | awk '{print $2}'| sed 's/\/64/\/96/')
ip -6 route add $subnet6 dev $dev table 1002

seq 0 255 | awk "{ printf \"neigh add proxy ${ifconfig_ipv6_local%:0:1}:1:%x dev eth0\n\", \$0 }" | ip --batch -

exit 0
