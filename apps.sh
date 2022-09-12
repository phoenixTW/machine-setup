#!/usr/bin/env bash

set +e
source ./user-interactions.sh

to_be_installed=$()

function install_app() {
    local APP_ID=$1
    local APP_NAME=${2:-${APP_ID}}

    if brew list --cask "${APP_ID}" 2>/dev/null 1>/dev/null; then
        already_installed "${APP_NAME}"
    else
        if confirm "Install ${APP_NAME}?"; then
            to_be_installed+=("${APP_ID}")
            echo "✔ enqueued $APP_NAME (${APP_ID})"
        else
            echo "✗ skipping $APP_NAME ($APP_ID)"
        fi
    fi
}

echo -e "\n\n\n    _                      
   /_\    _ __   _ __   ___
  / _ \  | '_ \ | '_ \ (_-<
 /_/ \_\ | .__/ | .__/ /__/
         |_|    |_|        \n\n\n\n"

## Internet & Browsers
install_app google-chrome "Google Chrome"
install_app brave-browser "Brave"

## Communications
install_app slack "Slack"
install_app zoom "Zoom.us Meeting"

## Productivity
install_app dropbox "Dropbox"
install_app notion "Notion - notion.so"
install_app alfred "Alfred - launcher"
install_app 1password "1Password"
install_app 1password-cli "1Password CLI"
install_app iterm2 "iTerm2 v3+"
install_app visual-studio-code "VS Code"
install_app intellij-idea-ce "IntelliJ IDEA Community"
install_app flycut "Flycut"

install_all "${to_be_installed[@]}"
