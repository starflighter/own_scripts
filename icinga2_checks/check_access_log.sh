#!/bin/bash

MISS=`sudo less /var/log/squid3/access.log | grep -i miss | wc -l`
DENIED=`sudo less /var/log/squid3/access.log | grep -i denied | wc -l`
GESAMT=`sudo less /var/log/squid3/access.log | wc -l`

echo -e "Traffic gesamt: $GESAMT Aufrufe\nMiss: $MISS, Denied: $DENIED |gesamt=${GESAMT}c miss=${MISS}c denied=${DENIED}c"
exit 0
