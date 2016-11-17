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

##little nagios/icinga/icinga2-plugin that shows some information from the squid access-log

MISS=`sudo less /var/log/squid3/access.log | grep -i miss | wc -l`
DENIED=`sudo less /var/log/squid3/access.log | grep -i denied | wc -l`
GESAMT=`sudo less /var/log/squid3/access.log | wc -l`

echo -e "Traffic gesamt: $GESAMT Aufrufe\nMiss: $MISS, Denied: $DENIED |gesamt=${GESAMT}c miss=${MISS}c denied=${DENIED}c"
exit 0
