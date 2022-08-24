# rsync-offsite-backup
Shell Script to Backup Websites and Databases from your VPS (AWS, Alibaba Cloud, Digital Ocean, Vultr).
Be sure to edit the configuration options at the beginning of the script to match your environment prior to executing.

# Usage:

1. Pull up a terminal or SSH into the target server.

2. Logon as root

<pre>sudo -i</pre>

3. Download the script(s).

<pre>wget https://raw.githubusercontent.com/pashamajied/rsync-backup/master/rsync-ssh-password.sh</pre>

4. Edit the configuration options at the beginning of the script to match your environment prior to executing.
<pre>
#----------------------------------------
# connection info
#----------------------------------------
REMOTE_HOST=yourserver.yourdomain.com
REMOTE_USER=username
REMOTE_PASSWORD=password123
REMOTE_PORT=22

# path to backup to files to
LOCAL_PATH=/home/pi/backup

# path to pull the files from
REMOTE_PATH=/www/wwwroot/*
</pre>

5. Make the script executable

<pre>chmod +x rsync-ssh-password.sh</pre>

6. Run the script.

<pre>./rsync-ssh-password.sh</pre>

8. Setup a cronjob to run the script daily/weekly if you choose.
<pre>
5 1   * * * /opt/rsync-ssh-password.sh >/dev/null 2>&1
</pre>