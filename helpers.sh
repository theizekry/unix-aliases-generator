#!/bin/bash
set -e

BASH_ALIASES_PATH="$HOME/.bash_aliases"

SCRIPT_PATH=$(dirname "$0")
CONFIG_PATH=${SCRIPT_PATH}/config

source ${SCRIPT_PATH}/colors.sh

function createDotBashAliasesIfNotExists() {
  if [ ! -f  "${BASH_ALIASES_PATH}" ]; then
    echo "${CYAN}Creating ${BASH_ALIASES_PATH} file."
    touch "${BASH_ALIASES_PATH}" && chmod 777 "${BASH_ALIASES_PATH}"
    echo "${GREEN}Created Successfully!"
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
function isValidCommand() {
  # Available Options & Arguments.
  array=('set-new sync')

  # Checking Command!
  [[ " ${array[*]} " =~ $1 ]] || die "${RED} Invalid Command: $1."
}

# Die and dump (6^6)
function dd() {
    echo $1;
    exit;
}

# Die the script and exit.
die () {
    echo >&2 "$@"
    displayHelp
    exit 1
}