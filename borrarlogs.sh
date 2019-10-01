#!/bin/bash
TAR=$(which tar)
DATE=$(which date)
GZIP=$(which gzip)
PATHTAR="/home/siebel/tar"
find /siebel/ses/siebsrvr/enterprises/SBA_82/sadbogca629/log/ \(-name "SBA*" -o -name "EAI*.log" -o -name "FINS*"\)  -mtime +5 -print -exec | $XARGS $TAR -cvf $PATHTAR/backup_eai_fins_logs-$($DATE +%Y%m%d).tar \;
$GZIP $PATHTAR/backup_eai_fins_logs-$($DATE +%Y%m%d).tar
find /siebel/ses/siebsrvr/enterprises/SBA_82/sadbogca629/logarchive/ -name "archive*" -mtime +15 -print -exec rm -rf {} \;
find /siebel/sai/applicationcontainer/logs \( -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;
find /siebel/ses/applicationcontainer/logs \( -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;
find /siebel/ses/siebsrvr/log \( -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;