#!/bin/bash

# stop dummy_echo and watcher

. service_util.sh
pid=`get_service_pid`

if [ "$pid" -le "0" ]
then
	exit 2
fi

. watcher_util.sh
stop_watcher $pid

kill $pid

