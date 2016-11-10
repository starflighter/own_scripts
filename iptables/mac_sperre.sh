#!/bin/bash
#

#
#iptables -A INPUT -m mac --mac-source 00:01:02:03:04:05  -j DROP
#



typeset -i zaehler
declare -a macs

zaehler=0

aktuelle_ip_tables="/etc/iptables/iptables_ssh"
neue_ip_tables="/etc/iptables/iptables_ssh_mac_sperre"
neue_ip_tables1_="/root/temp/bla"

mac_default="Hier MAC eintragen"

if [ $# -eq 0 ]
  then
    echo "Usage: $0 'MAC' ('MAC' 'MAC' ...), ansonsten wird mac_default genommen"
    macs[$zaehler]=$mac_default
fi


while [ $# -gt 0 ];do
        macs[$zaehler]=$1

	if [[ "${macs[$zaehler]}" =~ ^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$ ]];then
		#weitermachen
		zaehler+=1
	else
		echo "'$1' ist keine gueltige MAC"
                exit 1
	fi
	shift
done


cat $aktuelle_ip_tables > $neue_ip_tables

for i in ${macs[@]}
do
	echo $i
	awk -v n="7" '(NR==n) {printf "-A INPUT -m mac --mac-source " "'"$i"'" " -j DROP" "\n"}1' $neue_ip_tables > $neue_ip_tables1_
	cat $neue_ip_tables1_ > $neue_ip_tables
done

ln -f /etc/iptables/iptables_ssh_mac_sperre /etc/iptables/iptables_restore
iptables-restore /etc/iptables/iptables_restore

