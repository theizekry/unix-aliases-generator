
function createConfigFile() {
    # Directory exits, Let's create config file.
    echo '# Aliases Generator.' > "${SCRIPT_PATH}/config"
    echo "repository_path=$REPO_PATH" >> "${SCRIPT_PATH}/config"

    echo "${GREEN}setting your configurations ..." >&2
    echo 'Repository Linked successfully.' >&2
    echo
}

function askingUserForHisRepoPath() {
    read -p 'Please provide your dotfiles repository directory path:' REPO_PATH

    # replace the tilde ~ by the home path
    REPO_PATH="${REPO_PATH/#~/$HOME}"

    # replace the tilde ~ by the home path
    #REPO_PATH="${REPO_PATH/#$HOME/}"

    if  ! [ -e "$REPO_PATH" ]; then
      echo "${RED} Error this Directory does not exists, Please try again!"
      exit 0
    fi
}

function prepareToSync() {
    if ! [ -f "${SCRIPT_PATH}/config" ]; then
      askingUserForHisRepoPath
      createConfigFile
    fi

    # get repo path.
    REPO_PATH=$(perl -lne 'print $1 if /^repository_path=\s*(.*)/' ${CONFIG_PATH})

    # Check if repo path founded in user config, maybe for any reason deleted.
    # if repo path is an empty.
    if [ -z "${REPO_PATH}" ]; then
      rm "${CONFIG_PATH}"
      echo "${RED} Something went wrong, config file is invalid. try again!"
      exit 0
    fi

    if [ ! -d ${REPO_PATH} ]; then
      echo "${YELLOW}The synced path is not exists."
      exit 0
    fi
}

function syncToRemoteRepository() {

    # Sync $HOME/.bash_aliases

    # The main idea of Sync that I want to make my DotfileRepo up to date.
    # to do so, ( without this script ).
    # Add new alias,
    # then Source bash profile
    # then copy the $HOME/.bash_aliases to my repository (DotfileRepo path).
    # Then add, commit and push
    # with this script you only have to run bellow command
    # aliases set-new migrate 'php artisan migrate' --sync
    # you're Done!

    # Change the current path (pwd) to be dotFilesRepository path.
    cd ${REPO_PATH}

    cp $HOME/.bash_aliases .
    echo
    echo "${MAGENTA}[$HOME.bash_aliases] Copied! Successfully.${RESET}"
    echo

    echo "${CYAN}Syncing to Remote Repository, Please wait...${RESET}"
    echo

    if [[ -z $(git status --porcelain) ]];
    then
      # There's no change to sync.
      echo "${YELLOW}There's no change to sync, you're up to date!"
      # Return user back again to Previous working directory path!
      cd ~-;
      exit 0
    fi

    git pull origin master

    git add .

    git commit -m "Sync .bash_aliases file."

    git push origin master

    echo
    echo "${GREEN}Pushed Successfully, Your DotFiles is now up to date!${RESET}"

    # Return user back again to Previous working directory path!
    cd ~-;
}

function syncFromRemoteRepositoryToLocal() {

    # Sync From User Remote repository to Local.
    # The main idea of Sync in this mode, that we need to update the local .bash_aliases file.
    # by get the latest updates and copy file from the Remote repo. to Home user directory.

    # To do so,
    # Get User Repository path from user config!
    # change directory (cd `repo_path`)
    # run git pull to update local repository.
    # take a copy of bash file and move it to Home directory.
    # That's it, you're Done!

    # Change the current path (pwd) to be dotFilesRepository path.
    cd ${REPO_PATH}

    # Check if the Working tree not clean.
    # Git status, is has changes.
    if [[ ! -z $(git status --porcelain) ]];
    then
      echo "${RED}It seems you've some updates inside your repository!, Your working directory is not clean."
      echo "${CYAN}Syncing operation will be aborted to save your work"
      echo "So, please check your repository status and make your working tree clean. then try again to Syncing."
      # Return user back again to Previous working directory path!
      cd ~-;
      exit 0
    fi

    echo
    echo "${CYAN}Syncing to Remote Repository, Please wait...${RESET}"
    echo

    ### Check if we already synced with remote.
    changed=0
    git remote update && git status -uno | grep -q 'Your branch is behind' && changed=1

    # by running previous command, if we've change, we will sync.
    if [ $changed = 1 ]; then
      git pull origin master

      echo
      cp .bash_aliases $HOME;
      echo "${MAGENTA}[.bash_aliases] Copied! Successfully.${RESET}"

      echo
      echo "${GREEN}Synced Successfully!${RESET}"
    else
      echo
      echo "${YELLOW}Already up-to-date!${RESET}"
      echo
    fi

    # Return user back again to Previous working directory path!
    cd ~-;
}