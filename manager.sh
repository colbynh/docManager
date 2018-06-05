#!/bin/bash

# Set up logging
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>>gdriveSync.log 2>&1
set -e

REMOTE_SYNC_DIR=$1
LOCAL_SYNC_DIR=~/Desktop
SYNC_DIR_ID=""
STARTTIME=$(date '+%d/%m/%Y %H:%M:%S');

echo "================Syncing to gdrive @ $STARTTIME================"
echo "syncing from local dir: $LOCAL_SYNC_DIR"
echo "USER: $USER"
gdrive about

SYNC_DIR_ID=$(gdrive sync list | cut -d ' ' -f 1 | sed 's/Id//' | tr -d '[:space:]')
echo "Sync ID: $SYNC_DIR_ID"

if [[ $SYNC_DIR_ID = "" ]]; then 
    SYNC_DIR_ID=$(gdrive mkdir $REMOTE_SYNC_DIR | cut -d ' ' -f 2)
fi

gdrive sync upload $LOCAL_SYNC_DIR $SYNC_DIR_ID
ENDTIME=$(date '+%d/%m/%Y %H:%M:%S');

echo "================End of Sync $ENDTIME================"
