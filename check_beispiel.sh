#!/bin/bash

############################################################
#                                                          #
#Beispiel-Plugin für Icinga2, um die Funktion vorzufuehren #
#                                                          #
#10.03.16 yfischer Erstellung                              #
#                                                          #
############################################################

if [ "$1" = "-z" ];then
	Eingabe=$2
else
	echo "Parameter -z notwendig!"
	exit 3
fi

case $Eingabe in
	0) echo "OK: Es wurde die 0 eingegeben | perfdata=0"
	   exit 0;;
	1) echo "Warning: Es wurde die 1 eingegeben | perfdata=1"
	   exit 1;;
	2) echo "Critical: Es wurde die 2 eingegeben | perfdata=2"
	   exit 2;;
	*) echo "Unknown: Es wurde die 3 oder hoeher eingegeben | perfdata=3"
	   exit 3;;
esac

