#!/bin/bash

if [ `whoami` != 'root' ]; then
    exit 1
fi

ip route replace 10.6.0.0/16 via 10.6.0.2 table 1002
ip route replace 10.7.0.0/16 via 10.7.0.2 table 1002
ip route replace 10.8.0.0/16 via 10.8.0.2 table 1002

function update_route() {
    subnet=$(ip -6 addr show dev $1 | grep inet6 | awk '{print $2}')
    new_subnet=$(echo "$subnet" | sed 's/\/64/\/96/')
    ip -6 route del $subnet dev $1
    ip -6 route del $new_subnet
    ip -6 route add $new_subnet dev $1
}

update_route tun0
update_route tun1
update_route tun2

for i in {0..9} {a..f}; do
    for j in {0..9} {a..f}; do
        ip neigh add proxy 2001:da8:d800:f001:160:98:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:176:99:1:$i$j dev eth1
        ip neigh add proxy 2001:da8:d800:f001:160:99:1:$i$j dev eth0
    done
done

exit 0
