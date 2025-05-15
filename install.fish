#!/bin/fish
sudo pacman -S --noconfirm --needed waybar rofi nvim hyprpaper nemo keepassxc \
    cmake meson cpio pkg-config git g++ gcc base-devel inotify-tools sassc \
    wireplumber

# - (yay)
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si

# Hyprshade
yay -S hyprshade \
    headsetcontrol

# Hyprland plugins:
# - (hyprpm)
hyprpm update
hyprpm add https://github.com/shezdy/hyprsplit
hyprpm enable hyprsplit

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