#!/bin/bash

remove_pre_installed_apps() {
  sudo dnf remove -y gnome-tour \
    yelp gnome-abrt \
    gnome-maps \
    gnome-connections \
    gnome-contacts evince \
    libreoffice-writer \
    libreoffice-calc \
    libreoffice-impress \
    gnome-system-monitor \
    simple-scan
}
