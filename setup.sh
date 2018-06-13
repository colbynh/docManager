#!/bin/bash

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "* * * * * $HOME/docManager/fs.sh >> /tmp/fswatch.log 2>&1" >> mycron
#install new cron file
crontab mycron
rm mycron