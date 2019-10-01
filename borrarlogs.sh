#!/bin/bash
TAR=$(which tar)
DATE=$(which date)
GZIP=$(which gzip)
PATHTAR="/home/siebel/tar"
HOST=$HOSTNAME
echo $HOST
SERVER=$(echo $HOST |cut -d'.' -f1)
echo $SERVER
PATHLOG="/siebel/ses/siebsrvr/enterprises/SBA_82/$SERVER/log"
PATHARCHIVE="/siebel/ses/siebsrvr/enterprises/SBA_82/$SERVER/logarchive"
echo $PATHLOG
find $PATHLOG \( -name "SBA*" -o -name "EAI*.log" -o -name "FINS*" \)  -mtime +5 -print -exec | $XARGS $TAR -cvf $PATHTAR/backup_eai_fins_logs-$($DATE +%Y%m%d).tar \;
$GZIP $PATHTAR/backup_eai_fins_logs-$($DATE +%Y%m%d).tar
find $PATHARCHIVE -name "archive*" -mtime +15 -print -exec rm -rf {} \;
find /siebel/sai/applicationcontainer/logs \( -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;
find /siebel/ses/applicationcontainer/logs \( -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;
find /siebel/ses/siebsrvr/log \( -name "*.dmp" -o -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;

#ELIMINAR ARCHIVOS BACKUP VIEJOS
find $PATHTAR -name "backup*" -mtime +5 -print -exec rm -rf {} \;
