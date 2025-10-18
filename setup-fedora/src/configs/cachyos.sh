#!/bin/bash

cachy_config() {
  # 1. Repositório do Kernel
  sudo dnf copr enable bieszczaders/kernel-cachyos

  # 2. Repositório das Otimizações (SCX e KSMD)
  sudo dnf copr enable bieszczaders/kernel-cachyos-addons

  sudo dnf install kernel-cachyos kernel-cachyos-devel-matched

  sudo dnf install scx-scheds

  sudo systemctl enable --now scx_loader.service

  sudo dnf install uksmd
}
