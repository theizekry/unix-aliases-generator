#!/bin/bash
set -e

# Load helper files (Functions).
# shellcheck disable=SC1090
# shellcheck disable=SC2046
source $(dirname "$0")/functions.sh

# check if the user config file exists or not.
# If this the first time user run this script,
# we will generate the configuration file.
# Otherwise, Load this config.

if ! isConfigFileExists; then
  generateUserConfigurationFile
fi

# Load the Config Bash_src path.
# The Path saved in the config file with key `bash_src`
# So, grab this path value form config.
configPath=$(dirname "$0")/config
bachPath=$(grep ^"bachPath"= "${configPath}")
bachPath=${bachPath/bachPath=/""}

# Now, append very important command to use bash_file (source <bash_file> or . <bash_file>)
# the source Command to reload shell environment with new added aliases in out case.
# interacting with user command set new alias
if ! [ -f "$HOME"/.aliases ]; then
  echo "creating .aliases file into $HOME/.aliases..."
  touch "$HOME"/.aliases && chmod 777 "$HOME"/.aliases

  printf '%s\n' '# Aliases Generator' > "$HOME"/.aliases
  echo ". ~/.aliases" >> "${bachPath}"

  printf '%s\n' '# Aliases Generator' > "$HOME"/.aliases
  echo 'export PATH=$PATH:$HOME/.aliases' >> "${bachPath}"

  echo "Done!"
  echo '# For new alias Run: aliases-generator set-new <alias-name> <alias-value>'
else
  . ~/.aliases
fi

# Check command params, if no exit
if [[ $# -eq 0 ]]; then
  echo 'Error: Missing required parameters'
  echo '------- aliases-generator --help ----------------------------------------'
  echo '# For new alias Run: aliases-generator set-new <alias-name> <alias-value>'
  echo "# New alias example: aliases-generator set-new foo bar"
  echo "# For get just execute: <your-new-alias-name>."
  exit 0
fi

# Handle Set-New Command
# ($# count) Params must be 3 alias-name key and value.
# So, Check this rule.
if [[ ( "$1" = 'set-new' ) && (( $# -lt 3 )) ]]; then
  echo 'Error: Missing required parameters'
  echo '------- aliases-generator --help -----------------------'
  echo '# For new alias Run: aliases-generator set-new <alias-name> <alias-value>'
  exit 0
fi

# Handel is alias already exists
# if alias name is exists then quit with error message
if grep -q "$2" ~/.aliases; then
  echo "The alias $2 is already defined, pick another one and try again."
  exit 0
fi

# Append new alias to our .aliases file.
echo "alias $2='""$3""'" >> ~/.aliases
echo "alias $2 saved successfully, and ready to use."

# Reload current Terminal Session
# in another word, Replaces the shell with a completely new instance.
# to takes new updates.
exec "$SHELL"
