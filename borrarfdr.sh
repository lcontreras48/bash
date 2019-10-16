#!/bin/bash
DATE=$(which date)
PATHFDR="/siebel/ses/siebsrvr/bin/fdr"
PATHTAR="/home/siebel/tar"
echo $(FIND $PATHFDR \( -name "core*" -o -name "*.fdr" -o -name "callstack*" \) -type f -mtime +0) | xargs tar -cvf $PATHTAR/backup-$($DATE +%Y%m%d).tar
gzip $PATHTAR/backup-$($DATE +%Y%m%d).tar
find $PATHFDR -type f \( -name "core*" -o -name "*.fdr" -o -name "callstack*" \) -mtime +0 -delete
find $PATHTAR -type f -name "*.tar.gz" -mtime +5 -delete
