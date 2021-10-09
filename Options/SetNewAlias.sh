#!/bin/bash

function validateSetNewAliasArguments() {
  # arguments => $setCommand $aliasName $value.
  if [[ $# -lt 3 ]]; then
    echo "${RED} Error: Invalid Command Syntax."
    echo " ${WHITE}Usage:${MAGENTA} aliases <set-new> [<alias-name>] [<alias-value>]."
    exit;
  fi
}

function isAliasAlreadyExists() {
  # Handel is alias already exists
  # if alias name is exists then quit with error message
  if grep -q "$2" "${bash_aliases}"; then
    echo "${YELLOW}The alias $2 is already defined, choose another one and try again."
    exit 0
  fi
}

function saveNewAlias() {
  lines=$(cat ${bash_aliases})

  echo "${lines[0]}"

  # Append new alias to our .aliases file.
  echo "" >> "${bash_aliases}"
  echo "alias $2='""$3""'" >> "${bash_aliases}"
}

function finalize() {
  echo "${GREEN} - $2 alias Saved successfully, and ready to use."
  return;
}

# Handle Set-New Command
if [[ ( "$1" = 'set-new' ) ]]; then

  validateSetNewAliasArguments $1 $2 $3

  isAliasAlreadyExists $1 $2 $3

  saveNewAlias $1 $2 $3

  finalize $1 $2 $3
fi

