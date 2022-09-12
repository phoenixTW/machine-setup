## Text Style
bold=$(tput bold)
normal=$(tput sgr 0)

## Color
red=$(tput setaf 1)
green=$(tput setaf 2)
blue_alert=$(tput setaf 99)
magenta=$(tput setaf 5)

## User Interaction

# inspiration: http://unix.stackexchange.com/questions/92563/friendly-terminal-color-names-in-shell-scripts

success() {
  echo "${green}$*${normal}"
}

alert() {
  echo "${blue_alert}$*"$(tput sgr 0)
}

already_installed() {
  echo "${green}✔${normal}$* already installed"
}

terminate() {
  echo "${bold}${red} $@ ${normal}"
  exit 1
}

## confirm "<question>"
## accepts only "yes" as success
confirm() {
  local response="no"
  read -r -p "$1 [type 'yes|y', default is no]: " response
  if [ "$response" = "yes" ] || [ "$response" = "y" ] ; then
    return 0
  fi
  return 1
}

has_exec() {
  type $1 &>/dev/null
}

install_all() {
  for APP_ID in "$@"; do
    if [ -z "$APP_ID"]; then
      alert "Skipping installation for $APP_ID"
    else
        alert "Installing ${APP_ID}"
        brew install "${APP_ID}"
    fi
  done
}
