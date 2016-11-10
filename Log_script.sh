#!/bin/bash

cat /var/log/squid3/access.log | perl -p -e 's/^([0-9]*)/"[".localtime($1)."]"/e' | grep -v "192.168.2.99" >access.log.test
mv access.log.test /home/pi/Freigabe_AccessLog/access_log_$(date +%d"_"%m).log
>access.log
exit


