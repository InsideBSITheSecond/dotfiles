#!/bin/sh

# Needed programs
sudo pacman -S fish waybar rofi nvim hyprpaper hyprpm nemo keepassxc

# Hyprland plugins:
# - (hyprpm)
hyprpm add https://github.com/shezdy/hyprsplit
hyprpm enable hyprsplit

# - (yay)
yay -S hyprshade

#Fisher, Fish plugin manager:
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

#Fisher plugins:
fisher install IlanCosman/tide@v5
fisher install jethrokuan/z
fisher install patrickf1/fzf.fish
fisher install franciscolourenco/done
fisher install joseluisq/gitnow@2.12.0
fisher install paldepind/projectdo

# Tide configure
tide configure