#!/bin/bash

TEST=1
if [ $TEST -eq 1 ];then
	echo restart.sh called!
fi

/bin/bash stop_all.sh
/bin/bash start_all.sh

