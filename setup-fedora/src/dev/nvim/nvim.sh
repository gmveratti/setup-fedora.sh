#!/bin/bash

source ./goconfig.sh
source ./javaconfig.sh
source ./pythonconfig.sh
source ./typescriptconfig.sh

nvim_install() {
  sudo dnf install neovim
}

nvim_lazyvim_config() {
  git clone https://github.com/LazyVim/starter ~/.config/nvim

  rm -rf ~/.config/nvim/.git
}

language_nvim_config() {
  nvim_java_config
}
