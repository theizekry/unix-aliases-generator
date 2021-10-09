#!/bin/bash
set -e

# Require Helpers file.
source $(dirname "$0")/helpers.sh

# Start section Validations.

# Validate required arguments.
if [[ $# -eq 0 ]]; then
  displayHelp # Show Help screen.
  exit 0
fi

# Validate the given command options is available.
isValidOptions $1

# End section Validations.

# Create .bash_aliases if dose not exists.
createDotBashAliasesIfNotExists

# Require all available options.
source $(dirname "$0")/Options/options.sh

# Reload current Terminal Session
# Replaces the shell with a completely new instance to takes new updates.

exec "$SHELL"
