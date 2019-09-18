find /siebel/ses/siebsrvr/enterprises/SBA_82/sadbogca629/log/ -name "*.log" -mtime +5 -print -exec rm {} \;
find /siebel/ses/siebsrvr/enterprises/SBA_82/sadbogca629/logarchive/ -name "archive*" -mtime +15 -print -exec rm -rf {} \;
find /siebel/sai/applicationcontainer/logs \( -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;
find /siebel/ses/applicationcontainer/logs \( -name "*.txt*" -o -name "*.log*" \) -mtime +5 -print -exec rm {} \;
#oprueba