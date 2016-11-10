#!/bin/bash

mydate=`date +'%Y/%m/%d'`
less /var/lib/dhcp/dhcpd.leases | grep -B 4 "active" | sed -n '2p' | awk '{print $3}' >/tmp/lease.txt
output=`cat /tmp/lease.txt`

if [ -z ${output} ]
then
	output="0"
fi

#if [ $mydate == $output ]
if ( test ${mydate} == ${output})
then
	echo -e "Neues Geraet entdeckt : IP -`less /var/lib/dhcp/dhcpd.leases | grep -B 4 "active" | sed -n '1p' | awk '{print $2}'`- \n MAC -`less /var/lib/dhcp/dhcpd.leases | grep -A 4 "active" | sed -n '4p' | awk '{print $3}'`- |perfdata=2"
	exit 1
else
	echo "kein neues Geraet im Netz |perfdata=0"
fi

rm /tmp/lease.txt

exit 0
