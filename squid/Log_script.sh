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

##this little script, converts unixtime to readable time and deletes all lines who match "192.168.2.99"
##and it creates a new file that is renamed with the date of today in the filename

cat /var/log/squid3/access.log | perl -p -e 's/^([0-9]*)/"[".localtime($1)."]"/e' | grep -v "192.168.2.99" >access.log.test
mv access.log.test /home/pi/Freigabe_AccessLog/access_log_$(date +%d"_"%m).log
>access.log
exit


