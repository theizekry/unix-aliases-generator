#!/bin/bash
set -e

BASH_ALIASES_PATH="$HOME/.bash_aliases"

SCRIPT_PATH=$(dirname "$0")
CONFIG_PATH=${SCRIPT_PATH}/config

source ${SCRIPT_PATH}/colors.sh

function createDotBashAliasesIfNotExists() {
  if [ ! -f  "${BASH_ALIASES_PATH}" ]; then
    echo "${CYAN} - Creating ${BASH_ALIASES_PATH} file."
    touch "${BASH_ALIASES_PATH}" && chmod 777 "${BASH_ALIASES_PATH}"
    echo "${GREEN} - Created Successfully!" >&2
    echo '# Unix Aliases Generator.' > "${BASH_ALIASES_PATH}"
    echo '# Data 10/10/2021.' >> "${BASH_ALIASES_PATH}"
    echo "# Developed by Islam Zekry https://github.com/theizekry." >> "${BASH_ALIASES_PATH}"
    echo '# ------------------------------------------------------' >> "${BASH_ALIASES_PATH}"
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
  array=('set-new sync -h --help')

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