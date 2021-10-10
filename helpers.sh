#!/bin/bash
set -e

bash_aliases="$HOME/.bash_aliases"

# Colors.
BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`
RESET=`tput sgr0`

function createDotBashAliasesIfNotExists() {
  if [ ! -f  "${bash_aliases}" ]; then
    echo "${CYAN} - Creating ${bash_aliases} file."
    touch "${bash_aliases}" && chmod 777 "${bash_aliases}"
    echo "${GREEN} - Created Successfully!" >&2
    echo '# Unix Aliases Generator.' > "${bash_aliases}"
    echo '# Data 10/10/2021.' >> "${bash_aliases}"
    echo "# Developed by Islam Zekry https://github.com/theizekry." >> "${bash_aliases}"
    echo '# ------------------------------------------------------' >> "${bash_aliases}"
  fi
}

# Used to display help for all available Commands.
# <command> [<argument>] [<option>]
displayHelp() {
   echo " ${YELLOW}Unix Aliases Generator."
   echo " Data 10/10/2021."
   echo -e " Developed by Islam Zekry \e]8;;https://github.com/theizekry\a@theizekry\e]8;;\a."
   echo " ${WHITE}Usage:"
   echo " set-new:"
   echo "        aliases <set-new> [<alias-name>] [<alias-value>]."
   echo
}

# Validate the given command options
# is available.
function isValidOptions() {
  # Available Options (Commands).
  array=('set-new')

  # If not exists show error with help display.
  if [[ ! " ${array[*]} " =~ $1 ]]; then
    echo "${RED} Invalid option: $1."
    displayHelp
    exit;
  fi
}

# Die and dump (6^6)
function dd() {
    echo $1;
    exit;
}