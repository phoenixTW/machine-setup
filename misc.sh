#!/usr/bin/env zsh

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

function setup_agnoster_zshtheme() {
    alert "Updating ZSH theme to agnoster...\n\n"

    sed "s/ZSH_THEME=.*/ZSH_THEME=agnoster/g" ~/.zshrc
    source ~/.zshrc
    
    success "Successfully updated ZSH theme to agnoster\n\n"
    alert "\n\n To activate agnoster fonts please perform the followings.."
    echo "
        1. ${bold}Restart your terminal${normal}\n
        2. Go To ${bold}Preferences > Profiles > Text > Change Font${normal} and set it to something that has ${bold}'for Powerline'${normal}\n
        3. Save it and enjoy experience the updated theme\n
    "
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
setup_agnoster_zshtheme
