#!/bin/sh

freshclam

/freshclam.cron.sh &

sed -i 's/#TCPAddr 127.0.0.1/TCPAddr 0.0.0.0/g' /etc/clamav/clamd.conf
sed -i 's/#TCPSocket 3310/TCPSocket 3310/g' /etc/clamav/clamd.conf
sed -i 's/PidFile /run/clamav/clamd.pid/#PidFile /run/clamav/clamd.pid/g' /etc/clamav/clamd.conf
sed -i 's/#Foreground yes/Foreground yes/g' /etc/clamav/clamd.conf

mkdir /run/clamav
chown clamav:clamav /run/clamav/

clamd $@
