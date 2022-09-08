## User Interaction

# inspiration: http://unix.stackexchange.com/questions/92563/friendly-terminal-color-names-in-shell-scripts

success() {
  echo $(tput setaf 2)"$*"$(tput sgr 0)
}

alert() {
  echo $(tput setaf 99)"$*"$(tput sgr 0)
}

already_installed() {
  echo $(tput setaf 2)"✔"$(tput sgr 0) "$* already installed"
}

terminate() {
  echo $(tput bold)$(tput setaf 1) "$@" $(tput sgr 0)
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
