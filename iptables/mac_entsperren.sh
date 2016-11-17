#!/bin/bash

#drops the changes from the script mac_sperre.sh :-) (used as cronjob)

/bin/ln -f /etc/iptables/iptables_ssh /etc/iptables/iptables_restore
iptables-restore /etc/iptables/iptables_restore
