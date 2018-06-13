#!/bin/bash

#write out current crontabenv EDITOR=nano crontab -e
crontab -l > mycron
#echo new cron into cron file
echo "* * * * * $HOME/docManager/fs.sh >> /tmp/cronlog.log 2>&1" >> mycron
#install new cron file
crontab mycron
rm mycron