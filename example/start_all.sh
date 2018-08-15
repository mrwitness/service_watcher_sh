#!/bin/bash
# start dummy_echo and watcher
TEST=1

sh dummy_echo.sh &

. service_util.sh

if [ $TEST -eq 1 ];then
	echo start_all.sh trying to get service pid...
fi
pid=`get_service_pid_till_success`

if [ $TEST -eq 1 ];then
	echo start_all.sh success get service pid:$pid
fi

. watcher_util.sh
start_watcher $pid


