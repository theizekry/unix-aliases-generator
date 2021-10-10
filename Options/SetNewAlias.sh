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
  if grep -q "$2" "${bash_aliases}"; then
    echo "${YELLOW}The alias $2 is already defined, choose another one and try again."
    exit 0
  fi
}

function finalize() {
  echo "${GREEN}[$2] - Alias Saved successfully, and ready to use."
  return;
}

function syncWithDotFiles() {

  # Sync $HOME/.bash_aliases

  # The main idea of Sync that I want to make my DotfileRepo up to date.
  # to do so, ( without this script )
  # Add new alias,
  # then Source bash profile
  # then copy the $HOME/.bash_aliases to my repository (DotfileRepo path).
  # Then add, commit and push
  # with this script you only have to run bellow command
  # aliases set-new migrate 'php artisan migrate' --sync
  # you're Done!

  repoPath="$HOME/Code/Demo/ToGithub/dotfiles"
  if [ ! -d ${repoPath} ]; then
    echo "${YELLOW}The synced path is not exists."
  fi

  # Change the current path (pwd) to be dotFilesRepository path.
  cd ${repoPath}

  cp $HOME/.bash_aliases .
  echo "${MAGENTA}[$HOME.bash_aliases] Copied! Successfully.${RESET}"
  echo "${CYAN}Pushing to Remote Repository, Please wait...${RESET}"
  echo

  git add .
  git commit -m "Sync .bash_aliases with new added alias - '""$1""'"
  git push origin master

  echo
  echo "${GREEN}Pushed Successfully, Your DotFiles is now up to date!${RESET}"

  # Return user back again to Previous working directory path!
  cd ~-;

  return;
}

# Handle Set-New Options Scenario
if [[ ( "$1" = 'set-new' ) ]]; then

  # Arguments [option] [<alias-name>] [<alias-value>] [--<sync>]
  validateSetNewAliasArguments $1 $2 $3

  isAliasAlreadyExists $1 $2 $3

  # Append new alias to our .aliases file.
  echo "" >> "${bash_aliases}"
  echo "alias $2='""$3""'" >> "${bash_aliases}"

  if [ -n "$4" ] && [ $4 = '--sync' ]; then
      # Start Sync Operation
      # Passing alias with respect quotes "foo bar"
      syncWithDotFiles "${@: -3}";
  fi

  finalize $1 $2 $3
fi

