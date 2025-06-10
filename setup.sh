#!/bin/bash

echo -e "\n🚀 Iniciando configuração do sistema...\n"

# --------------------------
# CONFIGURANDO O DNF
# --------------------------
echo "🔧 Configurando o DNF..."
if ! grep -q "fastestmirror" /etc/dnf/dnf.conf; then
  sudo tee -a /etc/dnf/dnf.conf > /dev/null <<EOL
[main]
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True
EOL
  echo "✅ DNF configurado."
else
  echo "ℹ️ Configuração do DNF já aplicada."
fi

# --------------------------
# AJUSTANDO SWAPPINESS
# --------------------------
echo "🔧 Ajustando Swappiness..."
if ! grep -q "vm.swappiness" /etc/sysctl.conf; then
  echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
fi
sudo sysctl -p

# --------------------------
# REMOVENDO SOFTWARES PRÉ-INSTALADOS
# --------------------------
echo "🗑️ Removendo softwares pré-instalados..."
sudo dnf remove -y gnome-tour yelp gnome-abrt gnome-maps gnome-connections gnome-contacts evince \
  libreoffice-writer libreoffice-calc libreoffice-impress mediawriter

# --------------------------
# ATUALIZANDO SISTEMA
# --------------------------
echo "🔄 Atualizando sistema..."
sudo dnf upgrade --refresh -y

# --------------------------
# INSTALANDO RPM FUSION
# --------------------------
echo "📦 Instalando RPM Fusion..."
sudo dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y rpmfusion-free-release-tainted rpmfusion-nonfree-release-tainted

# --------------------------
# INSTALANDO CODECS E MULTIMÍDIA
# --------------------------
echo "🎧 Instalando codecs e pacotes multimídia..."
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate -y multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf install -y \
  amrnb amrwb faad2 flac gpac-libs lame libde265 libfc14audiodecoder mencoder x264 x265

# --------------------------
# GNOME TWEAKS
# --------------------------
echo "🎨 Instalando GNOME Tweaks..."
sudo dnf install -y gnome-tweaks

# --------------------------
# INSTALANDO DOCKER
# --------------------------
echo "🐳 Instalando Docker..."
sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo systemctl enable --now docker

# --------------------------
# INSTALANDO VSCODE
# --------------------------
echo "🧠 Instalando Visual Studio Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<EOL
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOL

sudo dnf install -y code

# --------------------------
# INSTALANDO NEOVIM
# --------------------------
echo "🧠 Instalando Neovim..."
sudo dnf install -y neovim

# --------------------------
# INSTALANDO UV (PYTHON)
# --------------------------
echo "🐍 Instalando UV para Python..."
curl -LsSf -o uv_install.sh https://astral.sh/uv/install.sh
bash uv_install.sh
rm uv_install.sh

# --------------------------
# INSTALANDO APLICATIVOS FLATPAK
# --------------------------
echo "📦 Instalando aplicativos Flatpak..."
flatpak_apps=(
  com.usebottles.bottles
  org.qbittorrent.qBittorrent
  com.google.Chrome
  com.mattjakeman.ExtensionManager
  io.dbeaver.DBeaverCommunity
  com.getpostman.Postman
  io.github.flattool.Warehouse
  org.onlyoffice.desktopeditors
  net.cozic.joplin_desktop
  com.anydesk.Anydesk
  org.gimp.GIMP
  me.iepure.devtoolbox
  org.localsend.localsend_app
  org.chromium.Chromium
  org.gnome.Papers
  dev.qwery.AddWater
  com.github.tchx84.Flatseal
)

for app in "${flatpak_apps[@]}"; do
  echo "➡️ Instalando $app..."
  flatpak install -y --noninteractive flathub "$app"
done

# --------------------------
# FINALIZAÇÃO
# --------------------------
echo -e "\n✅ Configuração concluída com sucesso!\n"
