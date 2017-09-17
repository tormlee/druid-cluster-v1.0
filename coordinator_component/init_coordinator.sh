#! /bin/bash
PWD=`pwd`
PIDP="$PWD/tmp/pid"

# start service
start(){
echo "Starting coordinator ..."
ERRORP="$PWD/tmp/error.log"
INFOP="$PWD/tmp/info.log"
bin/supervise -c conf/supervise/master-no-zk.conf 1>$INFOP 2>$ERRORP &
echo $! >$PIDP
echo "Info, error and pid in folder tmp"
echo "Done."
}

# stop service
stop(){
	read PID <$PIDP
	echo "Process id: $PID"
	kill -- $PID
	echo "coordinator stopped."
}

case $1 in
	start)
	start
	;;
	stop)
	stop
	;;
	restart)
	stop
	start
	;;
	*)
	echo "Please specific option -- start, stop or restart."
esac
