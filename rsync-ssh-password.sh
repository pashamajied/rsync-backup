#!/bin/bash

#----------------------------------------
# date info
#----------------------------------------
DATETIME=$(date "+%Y-%m-%d %H:%M:%S")
YEAR=$(date +%Y)
MONTH=$(date +%m)

#----------------------------------------
# telegram conf
#----------------------------------------
GROUP_ID=xxxxxxxxx
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

if [ ! -d "$LOCAL_PATH/$YEAR/$MONTH/$DAY" ];
  then mkdir --parents $LOCAL_PATH/$YEAR/$MONTH/$DAY;
fi

TEXT="Backup folder $REMOTE_PATH pada server $REMOTE_HOST dengan tujuan $LOCAL_PATH/$YEAR/$MONTH/wwwroot-$DATETIME.tar.gz BERHASIL dilakukan pada tanggal $DATETIME"

sshpass -p $REMOTE_PASSWORD /usr/bin/rsync -rsh -e ssh $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH $LOCAL_PATH/$YEAR/$MONTH/
sleep 1
curl -s --data "text=$TEXT" --data "chat_id=$GROUP_ID" 'https://api.telegram.org/bot'$BOT_TOKEN'/sendMessage?parse_mode=HTML'

tar -cvf $LOCAL_PATH/$YEAR/$MONTH/wwwroot-$DATETIME.tar.gz $LOCAL_PATH/$YEAR/$MONTH/
rm -rf $LOCAL_PATH/$YEAR/$MONTH/wwwroot

echo "Done"
