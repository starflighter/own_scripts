TIME=`date +%T | sed -e s/://g`
TIME2=`date +%T`

if [ $TIME -gt 090000 -a $TIME -lt 100000 ]; then
	printf "CRITICAL - $TIME2 | perfdata=1"
	exit 2
else
	printf  "OK - $TIME2 | perfdata=0"
	exit 0
fi
