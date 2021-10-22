#!/bin/bash

source ${SCRIPT_PATH}/Options/SyncingHelper.sh

# Checking if the option is Sync.
# If so, Check sync mode [ Default mode is from local to remote ].
# otherwise, from remote to Local repository.
if [[ ( "$1" = 'sync' ) ]]; then
    # For Default Sync.
    if [ $# -gt 0 ] && [ $# -eq 1 ]; then
      prepareToSync;
      syncToRemoteRepository;
    elif [ $# -eq 2 ]; then # Checking args if present!
      array=('-rtl --remote-to-local')
      [[ " ${array[*]} " =~ $2 ]] || die "${RED} Invalid Argument(s): $2."
      # Wants to sync from remote to Local!
      prepareToSync;
      syncFromRemoteRepositoryToLocal;
    fi
fi