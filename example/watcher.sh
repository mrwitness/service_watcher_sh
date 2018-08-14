#!/bin/bash
# Usage: ./service_watcher.sh,it will check service if alive in every 5s,if not restart the service
TEST=0

SLEEP_INTERVAL=5
RESTART_FILE="restart.sh"

if [ $# -ne 1 ]
then
	echo Usage: ./watcher.sh proc-id
	exit 2
fi
proc_id=$1

if [ ! -f $RESTART_FILE ];then
	echo file $RESTART_FILE not exist,exit now..
	exit 2
fi

. service_util.sh

service_started=`is_service_started`
service_alive=`is_service_alive`

if [[ $service_started != "1" ]];then
	echo service not started,exit now...
	echo goodbye...
	exit 2
fi

if [[ $service_alive != "1" ]]
then
	echo service started,but service is not alive,is there some bug in your code in the first place ?
	echo goodbye...
	exit 2
fi

now=`date +'%Y-%m-%d %H:%M:%S'`
echo watcher of pid:$proc_id success started! $now

while true
do
	service_started=`is_service_alive`
	if [[ $service_started == "0" ]]
	then
		now=`date +'%Y-%m-%d %H:%M:%S'`
		echo service not started,restart it now! $now
		/bin/bash $RESTART_FILE
		now=`date +'%Y-%m-%d %H:%M:%S'`
		echo watcher of pid:$proc_id is shutted down! $now
		exit 2
	fi
	sleep $SLEEP_INTERVAL
done
