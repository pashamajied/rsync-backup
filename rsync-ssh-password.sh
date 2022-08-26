#!/bin/sh

#Date
DATE=$(date "+%Y-%m-%d %H:%M:%S")

#telegram conf
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
REMOTE_PATH=/var/www/*
#----------------------------------------

TEXT="Backup folder $REMOTE_PATH pada server $REMOTE_HOST BERHASIL dilakukan pada tanggal $DATE"
echo "$TEXT"

sshpass -p $REMOTE_PASSWORD /usr/bin/rsync -rsh -e ssh $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH $LOCAL_PATH
sleep 1
curl -s --data "text=$TEXT" --data "chat_id=$GROUP_ID" 'https://api.telegram.org/bot'$BOT_TOKEN'/sendMessage?parse_mode=HTML'

echo "Done"
