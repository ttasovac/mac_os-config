#! /usr/bin/env bash

# Defines global settings.

# General
set -o nounset
set -o errexit
set -o pipefail
IFS=$'\n\t'

# Homebrew
export HOMEBREW_CURL_RETRIES=3

# Repositories
# export REPO_SUBLIME_TEXT_SETUP=15.1.0
# export REPO_DOTFILES=43.0.0

# Applications
export WALLET_APP_NAME="Wallet.app"
export WALLET_APP_URL="https://www.acrylicapps.com/downloads/releases/Wallet_350.zip"

#TNAS PC can't be downloaded with curl -- probably a referrer issue. 

# export QNAP_APP_NAME="Qfinder Pro.app"
# export QNAP_APP_URL="https://download.qnap.com/Storage/Utility/QNAPQfinderProMac-7.5.0.0428.dmg"
# export QNAP_PATH="QNAPQfinderProMac-7.5.0.0428"


# export DOCKER_APP_NAME="Docker.app"
# export DOCKER_VOLUME_NAME="Docker"
#
# if [[ "$(/usr/bin/arch)" == "arm64" ]]; then
#   export DOCKER_APP_URL="https://desktop.docker.com/mac/stable/arm64/Docker.dmg"
# else
#   export DOCKER_APP_URL="https://desktop.docker.com/mac/stable/amd64/Docker.dmg"
# fi



# Application Extensions
