#!/bin/sh

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# This is just the entrypoint, a little bash script that will install fish,
# and quickstart the main installation
# (since it includes some fish-y syntax)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Install fish
sudo pacman -S --noconfirm --needed fish

# Make it default
chsh -s $(which fish)

# Start install
mkdir logs
fish scripts/entry.fish