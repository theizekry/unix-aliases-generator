#!/bin/bash

# Require all available Options.
# Load the Sync to Remote Repository Service.

# source ${SCRIPT_PATH}/Options/SyncingToRemote.sh

# Options:

# [ For Help ]
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  displayHelp
exit; fi

# [Set New Alias Options]
source ${SCRIPT_PATH}/Options/SettingNewAliasOption.sh

# [Sync to  Or From Remote Repository ]
# By default the sync is from local to remote repository.
# but you can also sync the remote to you Local.
source ${SCRIPT_PATH}/Options/SyncOptionHandler.sh

