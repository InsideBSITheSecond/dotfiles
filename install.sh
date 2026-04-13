#!/bin/sh

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# This is just the entrypoint, a little bash script that will install fish,
# and quickstart the main installation
# (since it includes some fish-y syntax)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Making sure we are up to date
git pull

# Install fish
sudo pacman -S --noconfirm --needed fish which

# Make it default
chsh -s $(which fish)

# Start install
fish scripts/entry.fish