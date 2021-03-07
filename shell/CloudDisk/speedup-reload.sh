#!/bin/bash

kill_pid(){

echo "准备结束的PID: $1"
if [ -n "$1" ];then
	kill $1 >/dev/null 2>&1
	if ps | grep -q '^\s*'$1'\b';then
		echo "kill ${1}未正常结束，使用kill -9 强制结束"
		kill -9 $1 >/dev/null 2>&1
	fi
fi
}

reload(){

local pid
eval `ps -w | grep -E 'S\s*?(bash)? /root/.CloudDisk/speedup.sh' | awk 'NR==1{printf("pid=%s",$1)}'`
kill_pid "$pid"

nohup /root/.CloudDisk/speedup.sh > /root/.CloudDisk/speedup.log 2>&1 &
}


reload

