#!/bin/bash

#----------------------------------------
# date info
#----------------------------------------
DATETIME=$(date "+%d%m%Y-%H:%M")
TIME=$(date "+%H:%M:%S")
YEAR=$(date +%Y)
MONTH=$(date +%m)

#----------------------------------------
# telegram conf
#----------------------------------------
CHAT_ID=xxxxxxxxx
BOT_TOKEN=xxxxxxxxxx:xxxxxxxxxxxx-xxxxxxx-xxxxxxxxxxxxxx

#----------------------------------------
# connection info
#----------------------------------------
REMOTE_HOST=xxx.xx.xxx.x
REMOTE_USER=xxxx
REMOTE_PASSWORD=xxxx
REMOTE_PORT=22

# local path to download the files to
LOCAL_PATH=/home/pi/backup

# remote path to get the files from
REMOTE_PATH=/www/wwwroot
#----------------------------------------

# Prepare values
function prep ()
{
	echo "$1" | sed -e 's/^ *//g' -e 's/ *$//g' | sed -n '1 p'
}

#----------------------------------------
# OS details
#----------------------------------------
hostname=$(prep "$(hostname)")

if [ ! -d "$LOCAL_PATH/$YEAR/$MONTH" ];
  then mkdir --parents $LOCAL_PATH/$YEAR/$MONTH;
fi

TEXT="Hostname = $hostname [$TIME] %0ABackup folder = $REMOTE_PATH %0APada Server = $REMOTE_HOST %0Adengan tujuan $LOCAL_PATH/$YEAR/$MONTH/wwwroot-$DATETIME.tar.gz %0ABERHASIL"

sshpass -p $REMOTE_PASSWORD /usr/bin/rsync -rsh -e ssh $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH $LOCAL_PATH/$YEAR/$MONTH/
sleep 1
curl -s --data "text=$TEXT" --data "chat_id=$CHAT_ID" 'https://api.telegram.org/bot'$BOT_TOKEN'/sendMessage'

tar -cvf $LOCAL_PATH/$YEAR/$MONTH/wwwroot-$DATETIME.tar.gz $LOCAL_PATH/$YEAR/$MONTH/
sleep 1
rm -rf $LOCAL_PATH/$YEAR/$MONTH/wwwroot
