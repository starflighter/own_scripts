#!/bin/bash

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
echo $query | mysql -u root -proot iptables -h localhost
