#!/usr/bin/env bash

set +e
source ./user-interactions.sh

to_be_installed=$()
to_be_installed_asdf_tools=$()

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

function install_asdf_plugin() {
    local PLUGIN_NAME=$1
    local TOOL_VERSION=$2

    ## Installing plugins
    if asdf plugin list | grep "${PLUGIN_NAME}"; then
        already_installed "${PLUGIN_NAME} plugin"

    else
        if confirm "Install asdf plugin ${PLUGIN_NAME}?"; then
            asdf plugin add "${PLUGIN_NAME}"
            echo "✔ plugin installed ${PLUGIN_NAME}"
        else
            echo "✗ skipping ${PLUGIN_NAME}"
        fi
    fi

    ## Enqueuing app
    if asdf list "${PLUGIN_NAME}" "${TOOL_VERSION}"; then
        already_installed "${PLUGIN_NAME}" "${TOOL_VERSION}"
    else
        alert "Installing asdf tool ${PLUGIN_NAME} ${TOOL_VERSION}...\n"
        asdf install "${PLUGIN_NAME}" "${TOOL_VERSION}"
        success "---------------------- Installation Successful -----------------------------\n\n"

        alert "Setting up global value for ${PLUGIN_NAME} to ${TOOL_VERSION}...\n"
        asdf global "${PLUGIN_NAME}" "${TOOL_VERSION}"
        success "---------------------- ${PLUGIN_NAME} set successfully -----------------------------\n\n"
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
install_app gpg "GPG"
install_app xclip "xclip"
install_app openssl "OpenSSL"
install_app k9s "Kubernetes CLI tool"
install_app mongodb-compass "MongoDB Compass"


## DevOps and Tooling
install_asdf_plugin terraform "1.1.5"
install_asdf_plugin terragrunt "0.36.0"
install_asdf_plugin awscli "latest"
install_asdf_plugin aws-vault "latest"
install_asdf_plugin nodejs "latest"
install_asdf_plugin yarn "latest"
install_asdf_plugin golang "latest"
install_asdf_plugin gofumpt "latest"
install_asdf_plugin golangci-lint "latest"
install_asdf_plugin java "corretto-17.0.6.10.1"
install_asdf_plugin swag "latest"
install_asdf_plugin jq "jq"

install_all "${to_be_installed[@]}"
