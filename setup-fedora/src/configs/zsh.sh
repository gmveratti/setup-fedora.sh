#!/bin/bash

zsh_install() {
  sudo dnf install zsh

  chsh -s $(which zsh)

}

zsh_config() {
  echo "Instalando Oh_My_Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

}
