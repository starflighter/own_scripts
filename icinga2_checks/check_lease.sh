#!/bin/bash

## Copyright (c) 2016 Yvonne Fischer
##
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License
## as published by the Free Software Foundation; either version 3
## of the License, or any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

## nagios/icinga/icigna2-plugin that shows new leases of (unknown) devices from the dhcp-lease-file 
## works only if there are not more than 1 new lease in this time (4h)

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
