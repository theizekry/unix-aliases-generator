#!/bin/bash
set -e

function isConfigFileExists() {
    if [ -f $(dirname $0)/config ]; then
      echo true;
    else
      echo false;
    fi
}

function askForDefaultShellPath()
{
  echo 'Please choose your default dot shell path ex: .zshrc, .bashrc, .bash_aliases' >&2

  options=("$HOME/.bashrc" "$HOME/.zshrc" "Something else!" "Quit")

  select opt in "${options[@]}"
  do
      case $opt in
          "$HOME/.bashrc")
              echo $opt
              return;
              ;;
          "$HOME/.zshrc")
              echo $opt
              return;
              ;;
          "Something else!")
              read -e -p "Okay, Can you tell me your full path of your default shell?" FILEPATH
              # is Empty exit
              if [ -z $FILEPATH ]; then
                 echo 'Input cannot be blank, please try again!!' >&2
                 kill >&2
              fi
              echo ${eval $FILEPATH}
              return;
              ;;
          "Quit")
              break
              ;;
          *) echo "invalid option $REPLY"; kill >&2;
      esac
  done
}

function generateUserConfigurationFile()
{
    echo '# Welcome to Aliases Generator.' >&2

    bashPath=$(eval askForDefaultShellPath)
    configPath=$(dirname $0)/config

    echo '# Aliases Generator.' > ${configPath}
    echo bachPath=${bashPath} >> ${configPath}

    echo 'setting your configurations ...' >&2
    echo 'Done! Your Shell is now configured successfully.' >&2
}
