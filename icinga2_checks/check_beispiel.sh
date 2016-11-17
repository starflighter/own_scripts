#!/bin/bash

## Copyright (c) Yvonne Fischer
##
## This program is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public License
## as published by the Free Software Foundation; either version 2
## of the License, or (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

##dummy-script to show how plugins in nagios/icinga/icinga2 worked

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

