#!/bin/bash
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

