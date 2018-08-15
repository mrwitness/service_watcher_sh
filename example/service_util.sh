#!/bin/bash
# a demo service_util implement.

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


function get_service_pid {
	# only test in MAC
        PIDS=`ps aux|grep dummy_echo|grep -v grep|awk '{print $2}'`
        PIDS=${PIDS[*]%%/*}
	
	if [ "$PIDS" = "" ]
	then
		echo 0
	else
	        for pid in $PIDS
	        do
        	        echo $pid
	                break
	        done
	fi
}

function get_service_pid_till_success {
        pid=`get_service_pid`
        while true
        do
                if [ "$pid" -gt 0  ] 2>/dev/null;
                then
                        break
                else
                        sleep 1
                        pid=`get_service_pid`
                fi
        done
        echo $pid
}

