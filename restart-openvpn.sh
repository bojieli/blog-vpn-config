#!/bin/bash

DAEMON=/usr/sbin/openvpn
CONFDIR=/etc/openvpn

[ `whoami` != 'root' ] && exit 1
[ -z "$1" ] && echo "Usage: $0 <vpn-name> ..." && exit 1

while [ ! -z "$1" ]; do
    CONF=$CONFDIR/$1.conf
    [ ! -e "$CONF" ] && echo "config file $conf does not exist" && exit 1
    ps -A -o pid,cmd | grep "$DAEMON" | grep "$CONF" | \
        while read pid cmdline; do
            openfiles=$(lsof -n -p $pid)
            if [ ! -z "$(echo $openfiles | grep $DAEMON)" ]; then
                kill $pid && echo "$1 killed [PID $pid]"
                sleep 1
                echo "starting $1. cmdline: $cmdline"
                $cmdline && echo "$1 started"
            fi
        done

    [ -z "$(ps -A -o pid,cmd | grep $DAEMON | grep $CONF)" ] && echo "Error: daemon $1 not found"
    shift
done
