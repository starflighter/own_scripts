#!/bin/sh

# cron script for checking wlan connectivity
# change 192.168.1.1 to whatever IP you want to check.
IP_FOR_TEST="192.168.2.1"
PING_COUNT=1

PING="/bin/ping"

# ping test
$PING -c $PING_COUNT $IP_FOR_TEST > /dev/null 2> /dev/null
if [ $? -ge 1 ]
then
      sudo ifconfig eth0 down && sudo ifconfig eth0 up
      sudo /etc/init.d/networking restart
fi
