#!/usr/bin/env bash
set -e

echo "Setting up dotfiles..."

ln -sf ~/dotfiles/bash/.bashrc ~/.bashrc
ln -sf ~/dotfiles/bash/.bashrc.d ~/.bashrc.d
ln -sf ~/dotfiles/bash/.gitconfig ~/.gitconfig
[ ! -e ~/.gitconfig.local ] && cp ~/dotfiles/bash/.gitconfig.local.template ~/.gitconfig.local

echo "Done."
