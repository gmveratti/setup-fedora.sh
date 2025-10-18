#!/bin/bash

git_config() {
  git config --global user.name "Gabriel Veratti"
  git config --global user.email "gabriel.veratti@outlook.com.br"

  git config --global init.defaultBranch main

  git config --global core.editor "nvim"

  git config --global color.ui auto
}
