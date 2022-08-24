#!/bin/sh
#----------------------------------------
# connection info
#----------------------------------------
REMOTE_HOST=yourserver.yourdomain.com
REMOTE_USER=username
REMOTE_PASSWORD=password123
REMOTE_PORT=22

# local path to download the files to
LOCAL_PATH=/home/pi/backup

# remote path to get the files from
REMOTE_PATH=/www/wwwroot/*
#----------------------------------------

echo "Copying files from $REMOTE_HOST to Backup Server ........"

sshpass -p $REMOTE_PASSWORD /usr/bin/rsync -rsh -e ssh $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH $LOCAL_PATH

echo "Done"