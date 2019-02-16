#!/bin/bash

echo "[INFO] Starting......"

readonly DIR=~/.ghq/github.com/makotoeeee

if [ ! -d ${DIR} ]; then
  mkdir -p ${DIR}
fi

cd ${DIR}

readonly DOTFILES_DIR=~/.ghq/github.com/makotoeeee/dotfiles

if [ ! -n "$(ls $DOTFILES_DIR)" ]; then
  git clone https://github.com/makotoeeee/dotfiles
fi

cd ${DOTFILES_DIR}
make all

echo "[info] Finished!"
