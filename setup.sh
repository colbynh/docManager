#!/bin/bash

LOCAL_DIR=$1
REMOTE_DIR=$2

if [[ $(which brew) = "brew not found" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew install fswatch
brew install gdrive

chmod +x ./manager.sh

/bin/bash ./manager.sh $LOCAL_DIR $REMOTE_DIR

fswatch -o $LOCAL_DIR | xargs -n1 ./manager.sh
