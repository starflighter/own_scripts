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

##this script should run as cron and checks if the icinga2-daemon is still running, otherwise the daemon will be restarted
## DEPRECATED: uses SystemV and not Systemd !!

# Prüfen ob icinga2 läuft

if [ `pidof  icinga2` -ne "0" ]; #PID ist vorhanden, kann sich aber aufgehaengt haben
then
	service icinga2 status >/home/pi/temp.txt
	mylist=`cat /home/pi/temp.txt`
   	if [ "$mylist" == "icinga2 is not running ... failed!" ]; #Pruefen ueber /etc/init.d/icinga2 status, ob der Deamon haengt
		then
			killall icinga2 #alle laufenden icinga2 PIDs beenden
			/etc/init.d/icinga2 start # neu starten
			#exit 0 #Script beenden
			rm /home/pi/temp.txt
  	 fi

else
    echo "Icinga2 läuft nicht und wird neu gestartet" #kein PID gefunden -> Icinga2 ist sauber beendet
    /etc/init.d/icinga2 start # neu starten

fi


exit 0

