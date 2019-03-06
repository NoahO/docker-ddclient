#!/bin/bash

sleeptime=${DDNS_SLEEP:-3600}
ddclient_flags='-verbose -noquiet -foreground'

on_die()
{
	echo "Stopping..."
	exit 0
}

trap 'on_die' TERM SIGINT

sed -i 's/{dynamic_dns_server}/'$DDNS_SERVER'/' /etc/ddclient.conf &&
sed -i 's/{domain}/'$DDNS_DOMAIN'/' /etc/ddclient.conf &&
sed -i 's/{password}/'$DDNS_PASSWORD'/' /etc/ddclient.conf &&
sed -i 's/{protocol}/'$DDNS_PROTOCOL'/' /etc/ddclient.conf &&
sed -i 's/{host}/'$DDNS_HOST'/' /etc/ddclient.conf &&

while true
do
  ddclient -daemon=0 -verbose | grep -i 'success'
  sleep $sleeptime
done
