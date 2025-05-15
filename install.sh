#!/bin/sh

# Install fish
sudo pacman -S --noconfirm --needed fish

# Make it default
chsh -s $(which fish)

# Start install
fish install.fish