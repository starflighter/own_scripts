#!/bin/bash

#ToDO iptables generieren

#DB aufraeumen
query_double_ip="DELETE n1 FROM logging n1, logging n2 WHERE n1.timestamp > n2.timestamp AND n1.ip_addr = n2.ip_addr"
query_duplicate_row="DELETE n1 FROM logging n1, logging n2 WHERE n1.id < n2.id AND n1.timestamp = n2.timestamp AND n1.ip_addr = n2.ip_addr"
query_old_row="DELETE FROM logging WHERE timestamp < (NOW() - INTERVAL 30 DAY)"
query_list_ip="SELECT ip_addr FROM logging"

echo $query_double_ip | mysql -u root -proot iptables -h localhost
echo $query_duplicate_row | mysql -u root -proot iptables -h localhost
echo $query_old_row | mysql -u root -proot iptables -h localhost

#weitere dynamische Iptables generieren
#iptables -I INPUT 1 -s adash.m.taobao.com -j DROP
#iptables -I INPUT 1 -s umenqcloud.com -j DROP
#iptables -I INPUT 1 -s ads.mopub.com -j DROP
#iptables -I INPUT 1  -s upoll.umenqcloud.com -j DROP

#iptables -I OUTPUT 1 -s adash.m.taobao.com -j DROP
#iptables -I OUTPUT 1 -s umenqcloud.com -j DROP
#iptables -I OUTPUT 1 -s ads.mopub.com -j DROP
#iptables -I OUTPUT 1 -s upoll.umenqcloud.com -j DROP

ssh_brute_force_ip=`echo $query_list_ip | mysql -u root -proot iptables -h localhost`
for i in $ssh_brute_force_ip; do
	if [[ $i != "ip_addr" ]]; then
		#echo $i
		iptables -I INPUT 1 -s $i/32 -p tcp --dport 22 -j DROP
	fi
done


