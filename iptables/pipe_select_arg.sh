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

##script gets iptables-log and put the selected content into a consisting database

input=""

for var in "$@"
do
    input+=$var" "
done

echo "INPUT: $input"

timestamp=`echo $input | head -c19`
ip_source=`echo  $input | grep -o -E "SRC=(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" | cut -d'=' -f2`
dest_port=`echo $input | grep -o -E "DPT=[[:digit:]]{1,5}" | cut -d'=' -f2`
event=`echo $input | awk '{print $5}'`

#echo "timestamp: $timestamp"
#echo "src-ip: $ip_source"
#echo "dest-port: $dest_port"
#echo "ereignis: $event"
#echo

query="INSERT INTO logging (timestamp,ip_addr,port,ereignis) VALUES ('$timestamp', '$ip_source', '$dest_port', '$event');"

#echo $query
echo $query | mysql -u <user> -p<pass> iptables -h localhost
