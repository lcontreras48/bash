#!/bin/bash
FIND=$(which find)
XARGS=$(which xargs)
TAR=$(which tar)
DATE=$(which date)
GZIP=$(which gzip)
PATH="/siebel/ses/siebsrvr/bin/fdr"
PATHTAR="/home/siebel/tar"
echo $($FIND $PATH \( -name "core*" -o -name "*.fdr" -o -name "callstack*" \) -type f -mtime +0)   | $XARGS $TAR -cvf $PATHTAR/backup-$($DATE +%Y%m%d).tar
$GZIP $PATHTAR/backup-$($DATE +%Y%m%d).tar
$FIND $PATH -type f \( -name "core*" -o -name "*.fdr" -o -name "callstack*" \) -mtime +0 -delete
$FIND $PATHTAR -type f -name "*.tar.gz" -mtime +30 -delete
