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

##wrote as fun-script for x-mas


#fuer String-Vergleiche: ignore-case
shopt -s nocasematch

#Variablen
date_cur=`date +%F`
uid_cur=`id -u`
hostname_cur=`hostname`
username_cur=`whoami`

#1. Abgleich Hostname
if [[ $hostname_cur =~ "slv10110" ]];then
	echo "Das Script wird auf dem Server SLV10110 nicht ausgeführt, da es MEIN Linux-Server ist ;-)...  such' dir einen Anderen!"
	exit 1
fi

#2. Abgleich DAtum
#if [[ $date_cur -ne "2016-12-24" ]]; then
#	echo "#############################################################"
#	echo "#                                                           #"
#	echo "# Ja ist den heut' schon Weihnachten?? - ich glaube nicht!  #"
#	echo "# Warten auf Weihnachten du musst! - Yoda -                 #"
#	echo "#                                                           #"
#	echo "#############################################################"
#	exit 0
#fi

#3. Abfangen von Str-C mit der Funktion ctrl_c
trap ctrl_c SIGINT

#Definition von Funktionen
function tannenbaum() {

cat << "EOF"

      \ /
    -->*<--
      /_\
    o/_\_\
    /_/_/_\o
    /_\_\_\
   /_/o/_/_\
   /_\_\_\_\
  /_/_/_/_/_\o
  /_\_\_\_\_\
o/_/_/_/_/_/_\
 /_\_\_\o\_\_\
/_/_/_/_/_/_/_\
     [___]  o
     [___]
EOF

sleep 0.5
clear

sleep 0.2
}

function ctrl_c() {
clear

echo ""
echo "War das schon alles ??"
echo "2.Runde... startet jetzt!"
echo "...und diesmal nicht beenden, das Ende kommt von alleine!"
sleep 10

clear

#Zaehlschleife fuer Funktion Tannenbaum
i=0
while [ $i -le 30 ]; do

tannenbaum

let i=$i+1
done

echo "Der Prozess läuft noch immer ??"
echo "Jetzt hab ich keine Lust mehr und beende mich selber! :)"
echo ""
sleep 4

#uid auswerten
if [[ $uid_cur -eq "0" ]];then
	echo "Oh, das Script wurde als root auf $hostname_cur ausgeführt, aktiviere Backdoor ;-)"
else
	echo "Wie jetzt, das Script wurde nicht als root, sondern als $username_cur auf $hostname_cur ausgeführt ?? - Wie soll man da arbeiten können? ;-)"
	echo "Profi-Tipp: Führe das Script als root aus, wenn du dich traust!"
fi

echo ""
echo "Fröhliche Weihnachten !!"
sleep 6

exit 0
}

#Falls nichts von oben zutrifft, Ausfuehrung einer Endlosschleife mit der Funktion Tannenbaum
clear

echo "Das Script wurde gestartet, May the Force be with you !!"
sleep 5
clear

echo "Bereit ??"
sleep 1
clear

echo "3"
sleep 1
clear

echo "2"
sleep 1
clear

echo "1"
sleep 1
clear

echo "Los..."
sleep 1
clear

while [ true ]; do

tannenbaum

done
