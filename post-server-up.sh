#!/bin/bash

if [ `whoami` != 'root' ]; then
    exit 1
fi

ip route replace 10.7.0.0/16 via 10.7.0.2 table 1002
ip route replace 10.8.0.0/16 via 10.8.0.2 table 1002

ip -6 route del 2001:da8:d800:f001::/64 dev tun0
ip -6 route del 2001:da8:d800:f001::/64 dev tun1
ip -6 route replace 2001:da8:d800:f001:160:99::/96 dev tun0
ip -6 route replace 2001:da8:d800:f001:176:99::/96 dev tun1

for i in {0..9} {a..f}; do
    for j in {0..9} {a..f}; do
        ip neigh add proxy 2001:da8:d800:f001:160:99:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:176:99:1:$i$j dev eth1
    done
done

exit 0
