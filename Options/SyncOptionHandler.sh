#!/bin/bash

source ${SCRIPT_PATH}/Options/SyncingHelper.sh

if [[ ( "$1" = 'sync' ) ]]; then

    # Check sync mode [ Default mode is from local to remote (--ltr) ]
    # First Mode: From Local to Remote
    # Second Mode: From Remote to Local

    prepareToSync;
    syncToRemoteRepository;
fi