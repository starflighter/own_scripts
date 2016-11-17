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

## nagios/icinga/icinga2-plugin that shows the traffic that a single ip needs in 24h (daily logrotate of access.log)
## with performance-data

typeset -i anzahl 
typeset -i zaehler

zaehler=0

declare -a ip
declare -a traffic

s_ausgabe=""
s_log="/var/log/squid3/access.log"

#exit0 = OK
#exit1 = Warning
#exit2 = Critical
#exit3 = Unknown

#TODO:
#Dokumentieren

if [ $# -eq 0 ]
  then
    echo "Usage: $0 'IP' ('IP' 'IP' ...)"
    exit 3
fi

while [ $# -gt 0 ];do
	ip[$zaehler]=$1

	if [[ "${ip[$zaehler]}" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
		anzahl=0
		anzahl_=`cat $s_log | grep -F ${ip[$zaehler]}| awk '{print $5}'`
		if [ -z "$anzahl_" ];then
			anzahl_="0"
		fi

		for i in $anzahl_
		do
		      anzahl+=$i
		      traffic[$zaehler]=$anzahl
		done

		zaehler+=1
	else
  		echo "'$1' ist keine gueltige IP"
		exit 3
	fi
	shift
done

#s_ausgabe fuellen
zaehler=0
for i in ${ip[@]}
do
	ausgabe_text+="${i}: ${traffic[$zaehler]} bytes \n"
	ausgabe_perfdata+="${i}=${traffic[$zaehler]} "
	zaehler+=1
done
s_ausgabe="$ausgabe_text | $ausgabe_perfdata"

echo -e "$s_ausgabe"

exit 0

