#!/bin/bash

source ./src/configs/configs.sh
source ./src/configs/cachyos.sh
source ./src/configs/zsh.sh
source ./src/flatpaks/flatpaks.sh
source ./src/dev/docker.sh
source ./src/dev/gitconfig.sh
source ./src/dev/nvim/nvim.sh

echo -e "\n🚀 Iniciando configuração do sistema\n"

echo "🗑️ Removendo softwares pré-instalados"
remove_pre_installed_apps

echo "🔄 Atualizando sistema"
sudo dnf upgrade --refresh -y

echo "📦 Instalando RPM Fusion"
install_rpmfusion() {
  sudo dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  sudo dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted
}

echo "Instalando e fazendo Otimizacoes de CPU, Memoria e Kernel (CachyOS)"
cachy_config

echo "🐳 Instalando Docker"
install_docker

echo "Instalando Distrobox"
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

echo "Instalado Gnome Tweaks"
sudo dnf install gnome-tweaks

echo "Instalando Fastfetch"
sudo dnf install fastfetch

echo "Instalando ZSH"
zsh_install

echo "Configurando ZSH"
zsh_config

echo "Instalando Neovim"
nvim_install

echo "Configurando LazyVim(Neovim)"
nvim_lazyvim_config

echo "Configurando Linguagens de Programacao"
language_nvim_config

echo "Configurando Git"
git_config

echo "📦 Instalando aplicativos Flatpaks"
install_flatpaks
