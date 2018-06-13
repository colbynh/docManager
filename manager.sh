#!/bin/bash

# Set up logging
sync() {
    exec 3>&1 4>&2
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>>/tmp/gdriveSync.log 2>&1
    set -e

    LOCAL_SYNC_DIR="$HOME/Desktop"
    REMOTE_SYNC_DIR="vicSync"
    SYNC_DIR_ID=""
    STARTTIME=$(date '+%d/%m/%Y %H:%M:%S');

    echo "================Syncing to gdrive @ $STARTTIME================"
    echo "syncing from local dir: $LOCAL_SYNC_DIR"
    echo "PWD: $PWD"
    echo "USER: $USER"
    gdrive about

    SYNC_DIR_ID=$(gdrive sync list | cut -d ' ' -f 1 | sed 's/Id//' | tr -d '[:space:]')
    echo "Sync ID: $SYNC_DIR_ID"

    if [[ $SYNC_DIR_ID = "" ]]; then 
        SYNC_DIR_ID=$(gdrive mkdir $REMOTE_SYNC_DIR | cut -d ' ' -f 2)
    fi

    gdrive sync upload --keep-remote $LOCAL_SYNC_DIR $SYNC_DIR_ID
    cleanBadRemoteFiles
    ENDTIME=$(date '+%d/%m/%Y %H:%M:%S');
    echo "================End of Sync $ENDTIME================"
}

## Utility Functions ##

getBadRemoteFileNames() {
    local list_names=$(gdrive list --no-header | awk -v col=2 '{print $col}')
    REMOTE_FILES=()
    
    for element in "$list_names"
    do
        REMOTE_FILES+=(${element})
    done
}

getRemoteFileIds() {
    REMOTE_FILES_IDS=()
    local list_ids=$(gdrive list --no-header | awk -v col=1 '{print $col}')

    for element in "$list_ids"
    do
        REMOTE_FILES_IDS+=(${element})
    done
}

removeRemoteFile() {
    local fileId=$1
    local msg=$(gdrive delete $fileId)
    echo $msg

    if [[ $msg = *"Deleted"* ]]; then
        echo "Succes! $msg"
    else
        echo "Delete Failed! $msg"
    fi
}

cleanBadRemoteFiles() {
    local rmlist=$(gdrive list --no-header | grep "~\$*" | awk -v col=1 '{print $col}')

    if [[ ! -z rmlist ]]; then 
        echo "Cleaning up bad files..."
        for bf in $rmlist
        do
            removeRemoteFile ${bf}
        done
    fi
}

sync