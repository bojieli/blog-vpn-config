#!/bin/bash

DAEMON=/usr/sbin/openvpn
CONFDIR=/etc/openvpn

[ `whoami` != 'root' ] && exit 1
[ -z "$1" ] && echo "Usage: $0 <vpn-name> ..." && exit 1

while [ ! -z "$1" ]; do
    CONF=$CONFDIR/$1.conf
    [ ! -e "$CONF" ] && echo "config file $CONF does not exist" && exit 1
    ps -A -o pid,cmd | grep "$DAEMON" | grep "$CONF" | \
        while read pid cmdline; do
            openfiles=$(lsof -n -p $pid)
            if [ ! -z "$(echo $openfiles | grep $DAEMON)" ]; then
                kill $pid && echo "$1 killed [PID $pid]"
            fi
        done

    shift
done
