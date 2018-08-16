#!/bin/bash

TMP_FILE=".prom.tmp"

PUSH_GATEWAY="http://10.139.50.34:9091"
JOB_NAME="netcheck_java_server"
UP_METRIC="up"
RESTART_METRIC="auto_restart"

function update_service_status {
	if [ $# -ne 1 ];then
		return
	fi

	status=$1
	echo "$UP_METRIC $status" | curl -s --data-binary @- $PUSH_GATEWAY/metrics/job/$JOB_NAME
}

#update_service_status 0

function notify_service_restarted {
	if [ ! -f $TMP_FILE ];then
		touch $TMP_FILE
		echo 1 >$TMP_FILE
	else
		num=`cat $TMP_FILE`
		num=$[num+1]
		echo $num > $TMP_FILE
	fi
	num=`cat $TMP_FILE`
	echo "RESTART_METRIC $num" | curl -s --data-binary @- $PUSH_GATEWAY/metrics/job/$JOB_NAME
}
#notify_service_restarted

