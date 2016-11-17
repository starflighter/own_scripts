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

## nagios/icinga/icinga2-plugin that alarmed between 9 and 10 a.m.
## used for testing icinga2 (and if the daemon works...)

TIME=`date +%T | sed -e s/://g`
TIME2=`date +%T`

if [ $TIME -gt 090000 -a $TIME -lt 100000 ]; then
	printf "CRITICAL - $TIME2 | perfdata=1"
	exit 2
else
	printf  "OK - $TIME2 | perfdata=0"
	exit 0
fi
