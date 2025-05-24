#!/bin/fish

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# This is the main install script, it will install all the dependencies
# in order for the dotfiles to work properly
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

sudo pacman -S --noconfirm --needed waybar rofi nvim hyprpaper nemo keepassxc cava \
    cmake meson cpio pkg-config git stow gcc base-devel inotify-tools sassc \
    ttf-nerd-fonts-symbols \
    wireplumber

# - (yay)
git clone https://aur.archlinux.org/yay.git /tmp/yay
pushd /tmp/yay
makepkg -si
popd

# Hyprshade
yes | yay -S --sudoloop hyprshade \
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

# Last touch: stowing the dotfiles
fish scripts/stow.fish