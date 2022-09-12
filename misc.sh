#!/usr/bin/env sh

source ./user-interactions.sh

## Install powerline font to decorate terminal
function install_powerline_font() {
    alert "Installing powerline font...\n\n"

    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.sh
    cd ..
    rm -rf fonts

    success "Successfully installed powerline font\n\n"
}

function update_zshrc_with_theme() {
    alert "Proceeding to update ${bold}.zshrc${normal} file...\n\n"
    local ZSHRC_FILE_LOCATION="$HOME/.zshrc"
    local ZSHRC_FILE_BACKUP_LOCATION="${ZSHRC_FILE_LOCATION}.backup"
    local current_timestamp=$(date "+%Y%m%d-%H%M%S")

    if [ -d "${ZSHRC_FILE_BACKUP_LOCATION}" ]; then
        echo "${bold}${ZSHRC_FILE_BACKUP_LOCATION}${normal}\n\n"
        ls -al "${ZSHRC_FILE_BACKUP_LOCATION}"
    else
        alert "\n${bold}${red}${ZSHRC_FILE_BACKUP_LOCATION} directory does not exists. Creating one.\n"
        mkdir -p "${ZSHRC_FILE_BACKUP_LOCATION}"
    fi

    if [ -f "${ZSHRC_FILE_LOCATION}" ]; then
        alert "\nCreating backup of existing .zshrc file to ${bold}${ZSHRC_FILE_BACKUP_LOCATION}/.zshrc.${current_timestamp}${normal}\n\n"
        cp "${ZSHRC_FILE_LOCATION}" "${ZSHRC_FILE_BACKUP_LOCATION}/.zshrc.${current_timestamp}"

        cp ./dotfiles/.zshrc "${ZSHRC_FILE_LOCATION}"
        success "\nSuccessfully updated ${bold}${ZSHRC_FILE_LOCATION}${normal}\n\n"
    fi

    success "Successfully sourced ${bold}${ZSHRC_FILE_LOCATION}${normal}\n\n"
    alert "\n\n To activate agnoster fonts please perform the followings.."
    echo "
        1. ${bold}Restart your terminal${normal}\n
        2. Go To ${bold}Preferences > Profiles > Text > Change Font${normal} and set it to something that has ${bold}'for Powerline'${normal}\n
        3. Save it and enjoy experience the updated theme\n
    "

    alert "\n\n To reflect the changes of ${ZSHRC_FILE_LOCATION}${normal}\n"
    echo " Run: ${bold}source ${ZSHRC_FILE_LOCATION}${normal}\n"
}

## Reference: https://github.com/mbadolato/iTerm2-Color-Schemes
function update_color_scheme() {
    alert "Importing additional color schemes...\n\n"
    git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git color-schemes
    # Import all color schemes
    color-schemes/tools/import-scheme.sh color-schemes/schemes/*
    rm -rf color-schemes
    success "Color schemes imported successfully\n\n\n"
}

install_powerline_font
update_color_scheme
update_zshrc_with_theme
