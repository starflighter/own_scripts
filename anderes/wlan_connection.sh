###########################################################################
##                                                                       ##
##                         WLAN Reconnect Script                         ##
##                                                                       ##
## Creation:    01.02.2014                                               ##
## Last Update: 23.02.2014                                               ##
##                                                                       ##
## Copyright (c) 2014 by Georg Kainzbauer <http://www.gtkdb.de>          ##
##                                                                       ##
## This program is free software; you can redistribute it and/or modify  ##
## it under the terms of the GNU General Public License as published by  ##
## the Free Software Foundation; either version 2 of the License, or     ##
## (at your option) any later version.                                   ##
##                                                                       ##
###########################################################################
#!/bin/bash

# WLAN interface name
INTERFACE=eth0

# Lock file
LOCKFILE=/var/tmp/wlan_connection.lock

###################################################################
# NORMALLY THERE IS NO NEED TO CHANGE ANYTHING BELOW THIS COMMENT #
###################################################################

if [ -f ${LOCKFILE} ] ; then
  /bin/kill -0 $(cat ${LOCKFILE}) >/dev/null 2>&1
  if [ $? -eq 0 ] ; then
    /bin/echo "Previous process still running."
    exit 1
  else
    /bin/echo "Deprecated lock file found. Remove lock file."
    /bin/rm -f ${LOCKFILE}
  fi
fi

/bin/echo $$ >${LOCKFILE}

/sbin/ifconfig ${INTERFACE} | grep -q "inet"
if [ $? -ne 0 ] ; then
  /bin/echo "Wireless network connection down. Attempt to reconnect."
  /sbin/ifup --force ${INTERFACE} >/dev/null 2>&1

  /sbin/ifconfig ${INTERFACE} | grep -q "inet"
  if [ $? -eq 0 ] ; then
    /bin/echo "Wireless network connection recovered."
  else
    /bin/echo "Wireless network connection still down."
  fi
else
  /bin/echo "Wireless network connection available. Nothing to do."
fi

/bin/rm -f ${LOCKFILE}

exit 0
