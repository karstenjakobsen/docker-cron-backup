#!/bin/sh
set -e

{ echo ""; } | crontab -

if [ -z "$SCHEDULE" ] 
then
echo "SCHEDULE environment not defined! Using 0 0 * * *"
SCHEDULE="0 0 * * *"
fi

if [ ! -z "$DIRS" ] 
then
  crontab -l | { cat; echo "$SCHEDULE bash $PWD/backup.sh"; } | crontab -
else
  echo "DIRS environment not defined!"
  exit 1
fi

if [ ! -z  "$SCRIPT" ]
then
  crontab -l | { cat; echo "$SCHEDULE $SCRIPT"; } | crontab -
else
  echo "COMMAND environment not defined!"
fi

crond -s /var/spool/cron/crontabs -f -L /var/log/cron/cron.log "$@"
