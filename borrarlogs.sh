#!/bin/bash
FIND=$(which find)
TAR=$(which tar)
DATE=$(which date)
GZIP=$(which gzip)
PATHTAR="/home/siebel/tar"
HOST=$HOSTNAME
SERVER=$(echo $HOST |cut -d'.' -f1)
PATHLOG="/siebel/ses/siebsrvr/enterprises/SBA_82/$SERVER/log"
PATHARCHIVE="/siebel/ses/siebsrvr/enterprises/SBA_82/$SERVER/logarchive"
find $PATHLOG \( -name "SBA*" -o -name "EAI*.log" -o -name "FINS*" \)  -mtime +5 -print -exec $TAR rvf $PATHTAR/backup_eai_fins_logs-$($DATE +%Y%m%d).tar {} \;
find $PATHLOG "*.log" -mtime +5 -print -exec rm -rf {} \;
$GZIP $PATHTAR/backup_eai_fins_logs-$($DATE +%Y%m%d).tar
find $PATHARCHIVE -name "archive*" -mtime +15 -print -exec rm -rf {} \;
find /siebel/sai/applicationcontainer/logs \( -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;
find /siebel/ses/applicationcontainer/logs \( -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;
find /siebel/ses/siebsrvr/log \( -name "*.dmp" -o -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;

#ELIMINAR ARCHIVOS BACKUP VIEJOS
find $PATHTAR -name "backup*" -mtime +5 -print -exec rm -rf {} \;
