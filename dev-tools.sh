#!/usr/bin/env bash

set +e
source ./user-interactions.sh

to_be_installed=$()

function install_app() {
    local APP_ID=$1
    local APP_NAME=${2:-${APP_ID}}

    if brew list "${APP_ID}" 2>/dev/null 1>/dev/null; then
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

echo -e "\n\n\n  ___                  _____               _      
 |   \   ___  __ __   |_   _|  ___   ___  | |  ___
 | |) | / -_) \ V /     | |   / _ \ / _ \ | | (_-<
 |___/  \___|  \_/      |_|   \___/ \___/ |_| /__/
                                                  \n\n\n\n"

## Internet
install_app wget

## Productivity
install_app gh "Github CLI"
install_app tree "Tree"
install_app autojump "AutoJump"
install_app act "act: Github Action runs locally"
install_app tig "Tig: text-mode interface for Git"
install_app docker "Docker"
install_app gpg "GPG"
install_app xclip "xclip"

install_all "${to_be_installed[@]}"
