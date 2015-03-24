#!/bin/bash

if [ `whoami` != 'root' ]; then
    exit 1
fi
ip route replace 10.1.0.0/16 via 10.1.0.2 table 1002
ip route replace 10.2.0.0/16 via 10.2.0.2 table 1002
ip route replace 10.3.0.0/16 via 10.3.0.2 table 1002
ip route replace 10.4.0.0/16 via 10.4.0.2 table 1002
ip route replace 10.6.0.0/16 via 10.6.0.2 table 1002
ip route replace 10.7.0.0/16 via 10.7.0.2 table 1002
ip route replace 10.8.0.0/16 via 10.8.0.2 table 1002
ip route replace 10.9.0.0/16 via 10.9.0.2 table 1002
ip route replace 10.10.0.0/16 via 10.10.0.2 table 1002
ip route replace 10.11.0.0/16 via 10.11.0.2 table 1002

ip route replace 10.21.0.0/16 via 10.21.0.2 table 1002
ip route replace 10.22.0.0/16 via 10.22.0.2 table 1002
ip route replace 10.23.0.0/16 via 10.23.0.2 table 1002
ip route replace 10.24.0.0/16 via 10.24.0.2 table 1002
ip route replace 10.25.0.0/16 via 10.25.0.2 table 1002
ip route replace 10.26.0.0/16 via 10.26.0.2 table 1002
ip route replace 10.27.0.0/16 via 10.27.0.2 table 1002
ip route replace 10.28.0.0/16 via 10.28.0.2 table 1002
ip route replace 10.29.0.0/16 via 10.29.0.2 table 1002
ip route replace 10.30.0.0/16 via 10.30.0.2 table 1002
ip route replace 10.31.0.0/16 via 10.31.0.2 table 1002
ip route replace 10.32.0.0/16 via 10.32.0.2 table 1002

function update_route() {
    subnet=$(ip -6 addr show dev $1 | grep inet6 | awk '{print $2}')
    new_subnet=$(echo "$subnet" | sed 's/\/64/\/96/')
    ip -6 route add $new_subnet dev $1 table 1002
}

ip -6 route flush table 1002
update_route tun0
update_route tun1
update_route tun2
update_route tun3
update_route tun4
update_route tun5
update_route tun-worker-1
update_route tun-worker-2
update_route tun-worker-3
update_route tun-worker-4
update_route tun-worker-5
update_route tun-worker-6
update_route tun-worker-7
update_route tun-worker-8
update_route tun-worker-9
update_route tun-worker-10
update_route tun-worker-11
update_route tun-worker-12
update_route tun-worker-13
update_route tun-worker-14
update_route tun-worker-15
update_route tun-worker-16

ip -6 rule del from all lookup 1002 pref 1000 2>/dev/null
# this is to ensure local subnet do not go through gateway
ip -6 route add 2001:da8:d800:f001::/64 dev eth0 table 1002 2>/dev/null
ip -6 rule add from all lookup 1002 pref 1000

for i in {0..9} {a..f}; do
    for j in {0..9} {a..f}; do
        ip neigh add proxy 2001:da8:d800:f001:160:97:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:160:98:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:176:99:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:160:99:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:160:100:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:160:101:1:$i$j dev eth0

        ip neigh add proxy 2001:da8:d800:f001:100:1:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:2:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:3:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:4:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:21:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:22:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:23:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:24:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:25:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:26:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:27:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:28:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:29:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:30:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:31:1:$i$j dev eth0
        ip neigh add proxy 2001:da8:d800:f001:100:32:1:$i$j dev eth0
    done
done

exit 0
