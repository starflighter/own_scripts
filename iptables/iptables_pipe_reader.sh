#!/bin/bash

pipe=/var/log/iptables-pipe.log

trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
    chmod 777 $pipe
fi

while true
do
    if read line <$pipe; then
	#echo $line
	/usr/local/bin/pipe_select_arg.sh $line
    fi
done 
