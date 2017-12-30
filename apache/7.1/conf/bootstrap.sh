#!/bin/sh

# set apache as owner/group
if [ "$FIX_OWNERSHIP" != "" ]; then
	chown -R site:site /home/site/
fi

# display logs
tail -F /var/log/apache2/sites/error.log &

echo "[i] Starting daemon..."
# run apache httpd daemon
httpd -D FOREGROUND