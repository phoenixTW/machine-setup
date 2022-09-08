#!/usr/bin/env bash

## installs various prerequisit softwares
## typically used once per new machine

source ./user-interactions.sh

if xcode-select -p 1>/dev/null; then
  already_installed "Command line tools"
else
  xcode-select --install
fi

if has_exec brew; then
  already_installed "Homebrew"
else
  alert "Reference: https://docs.brew.sh/Installation"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ -d "$HOME/.oh-my-zsh" ]; then
  already_installed "Oh My Zsh!"
else
  alert "Reference: https://github.com/robbyrussell/oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

## Version Managers - for languages/platforms like JVM, Node, Ruby, Python etc.

if [ -d "$HOME/.asdf" ]; then
  already_installed "asdf"
else
  alert "Reference: https://asdf-vm.com/guide/getting-started.html#_2-download-asdf"
  brew install asdf
  echo ". /usr/local/opt/asdf/libexec/asdf.sh" >> ~/.zshrc
  source ~/.zshrc
fi
