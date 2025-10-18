#!/bin/bash

install_flatpaks() {

  flatpak install flathub -y \
    com.discordapp.Discord \
    org.gimp.GIMP \
    com.github.tchx84.Flatseal \
    com.mattjakeman.ExtensionManager \
    com.visualstudio.code \
    org.onlyoffice.desktopeditors \
    org.qbittorrent.qBittorrent \
    org.localsend.localsend_app \
    com.rustdesk.RustDesk \
    io.github.flattool.Warehouse \
    com.anydesk.Anydesk \
    dev.qwery.AddWater \
    com.getpostman.Postman \
    io.dbeaver.DBeaverCommunity \
    io.podman_desktop.PodmanDesktop \
    org.gnome.Papers \
    org.chromium.Chromium \
    io.github.zaedus.spider \
    net.cozic.joplin_desktop \
    com.ranfdev.DistroShelf
}
