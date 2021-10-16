
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
    # to do so, ( without this script )
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