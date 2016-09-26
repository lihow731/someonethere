#! /bin/sh
### BEGIN INIT INFO
# Provides:          urs
# Required-Start:    $syslog $remote_fs $network $named $time
# Required-Stop:     $syslog $remote_fs $network $named $time
# Should-Start:      network
# Should-Stop:       network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: urs - reply someonethere message via UDP
# Description: This daemon will reply the domain name and IP address when someone send "someonethere" message via UDP port 8613.

### END INIT INFO

DAEMON=/usr/bin/udp-reply-someonethere
NAME=urs
PIDFILE=/var/run/urs/$NAME.pid
DESC="Reply someonethere message"

unset TMPDIR

test -x $DAEMON || exit 0

. /lib/lsb/init-functions

SSD_OPTIONS="--quiet --pidfile $PIDFILE --make-pidfile"

case "$1" in
  start)
	log_begin_msg "Starting $DESC: $NAME"

	mkdir -p `dirname "$PIDFILE"`
	start-stop-daemon --start --oknodo --background $SSD_OPTIONS --exec $DAEMON
	log_end_msg $?
	;;
  stop)
	log_begin_msg "Stopping $DESC: $NAME"
	start-stop-daemon --stop --retry 5 --oknodo $SSD_OPTIONS --name $NAME
	log_end_msg $?
        rm -f $PIDFILE
	;;
  restart|force-reload)
	log_begin_msg "Restarting $DESC: $NAME"
	if start-stop-daemon --stop --retry 5 --oknodo $SSD_OPTIONS --name $NAME; then
		start-stop-daemon --start --background $SSD_OPTIONS --exec $DAEMON
	fi
	log_end_msg $?
	;;
  status)
        status_of_proc "$DAEMON" "$NAME" && exit 0 || exit $?
	;;
  *)
	N=/etc/init.d/${0##*/}
	echo "Usage: $N {start|stop|force-reload|restart|status}" >&2
	exit 1
	;;
esac

exit 0
