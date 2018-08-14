#!/bin/bash
# service utilitys,when you use it in PRODUCTION,you must custom @is_service_alive,@is_service_started,@get_service_pid

test=0
function is_service_alive {
	is_service_started
}

function is_service_started {
	PIDS=`ps aux|grep dummy_echo|grep -v grep|wc -l`
	if [ $PIDS -ge 1 ];then
		echo 1
	else
		echo 0
	fi
}

#is_service_started
#is_service_alive


