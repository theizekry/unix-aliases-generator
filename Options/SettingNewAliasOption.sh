#!/bin/bash

function validateSetNewAliasArguments() {
  # arguments => $setCommand $aliasName $value.
  if [[ $# -lt 3 ]]; then
    echo "${RED} Error: Invalid Command Syntax."
    echo " ${WHITE}Usage:${MAGENTA} aliases <set-new> [<alias-name>] [<alias-value>]."
    exit 0;
  fi
}

function isAliasAlreadyExists() {
  # Handel is alias already exists
  # if alias name is exists then quit with error message
  if grep -q "$2" "${BASH_ALIASES_PATH}"; then
    echo "${YELLOW}The alias $2 is already defined, choose another one and try again."
    exit 0
  fi
}

function finalize() {
  echo "${GREEN}[$2] - Alias Saved successfully, and ready to use."
  return;
}

# Handle Set-New Options Scenario
if [[ ( "$1" = 'set-new' ) ]]; then

  # Arguments [option] [<alias-name>] [<alias-value>] [--<sync>]
  validateSetNewAliasArguments $1 $2 $3

  isAliasAlreadyExists $1 $2 $3

  # Append new alias to our .BASH_ALIASES_PATH file.
  echo "" >> "${BASH_ALIASES_PATH}"
  echo "alias $2='""$3""'" >> "${BASH_ALIASES_PATH}"

  if [ -n "$4" ] && [ $4 = '--sync' ]; then
      # Start Sync Operation
      source ${SCRIPT_PATH}/Options/SyncingHelper.sh
      prepareToSync;
      syncToRemoteRepository;
  fi

  finalize $1 $2 $3
fi

