#!/bin/bash

# Atualizando e configurando o DNF
echo "Configurando o DNF..."
sudo bash -c 'echo -e "[main]\nfastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True" >> /etc/dnf/dnf.conf'

# Ajustando o Swappiness
echo "Ajustando Swappiness..."
sudo bash -c 'echo "vm.swappiness=10" >> /etc/sysctl.conf'
sudo sysctl -p

# Remover Softwares Pré Instalados
echo "Removendo softwares pré-instalados..."
sudo dnf remove -y gnome-tour yelp gnome-abrt gnome-maps gnome-connections gnome-contacts evince
sudo dnf remove -y libreoffice-writer libreoffice-calc libreoffice-impress mediawriter

# Atualizar o Sistema
echo "Atualizando o sistema..."
sudo dnf upgrade --refresh -y

# Instalando Repositórios RPM Fusion
echo "Instalando repositórios RPM Fusion..."
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm -y
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-42
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm -y
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-42
sudo dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted -y

# Instalando Flatpak e Flathub
echo "Instalando o Flatpak e repositório Flathub..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalando Codecs e Pacotes Multimídia
echo "Instalando codecs e pacotes multimídia..."
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf update -y @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf install -y amrnb amrwb faad2 flac gpac-libs lame libde265 libfc14audiodecoder mencoder x264 x265

# Instalando GNOME Tweaks
echo "Instalando GNOME Tweaks..."
sudo dnf install -y gnome-tweaks

# Instalando Docker
echo "Instalando Docker..."
sudo dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker

# Instalando Aplicativos Flatpak
echo "Instalando aplicativos Flatpak..."
flatpak_apps=(
  com.usebottles.bottles
  org.qbittorrent.qBittorrent
  com.google.Chrome
  com.mattjakeman.ExtensionManager
  com.visualstudio.code
  io.dbeaver.DBeaverCommunity
  com.getpostman.Postman
  org.libreoffice.LibreOffice
  io.github.flattool.Warehouse
  net.cozic.joplin_desktop
  com.anydesk.Anydesk
  com.discordapp.Discord
  com.valvesoftware.Steam
  org.gimp.GIMP
  me.iepure.devtoolbox
  org.localsend.localsend_app
  org.chromium.Chromium
  org.torproject.torbrowser-launcher
  org.gnome.Papers
  io.github.ilya_zlobintsev.LACT
  dev.qwery.AddWater
  com.github.tchx84.Flatseal
)

echo "Configuração concluída com sucesso!"

