#!/bin/bash
PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin

isRunning=`ps aux -a | grep -i "[f]swatch"`

if [[ -z "$isRunning" ]]; then
    echo "fswatch is not running. Starting"
    nohup fswatch -o $HOME/Desktop | xargs -n1 $HOME/docManager/manager.sh
fi