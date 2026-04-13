#!/bin/fish

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# This is the main install script, it will install all the dependencies
# in order for the dotfiles to work properly
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

sudo pacman -S --noconfirm --needed quickshell rofi nvim hyprpaper nemo keepassxc cliphist \
    cmake meson cpio pkg-config git stow gcc base-devel inotify-tools sassc \
    ttf-nerd-fonts-symbols fzf \
    wireplumber \
    yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick

# - (yay)
git clone https://aur.archlinux.org/yay.git /tmp/yay
pushd /tmp/yay
makepkg -si
popd

# Hyprshade
yes | yay -S --sudoloop --noconfirm --needed hyprshade \
    headsetcontrol

# Hyprland plugins:
# - (hyprpm)
hyprpm update
hyprpm add https://github.com/shezdy/hyprsplit
hyprpm enable hyprsplit

#Fisher, Fish plugin manager:
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

#Fisher plugins:
fisher install pure-fish/pure
fisher install jethrokuan/z
fisher install patrickf1/fzf.fish
fisher install franciscolourenco/done
fisher install joseluisq/gitnow@2.12.0
fisher install paldepind/projectdo

# Pure configure
set -U pure_show_numbered_git_indicator true

set -U pure_show_jobs true

set -U pure_separate_prompt_on_error true
set -U pure_show_exit_status true
set -U pure_convert_exit_status_to_signal true

set -U pure_symbol_ssh_prefix true
set -U pure_show_system_time true

set -U pure_show_prefix_root_prompt true

# Yazi configuration
ya pkg add stelcodes/bunny

# Last touch: stowing the dotfiles
fish scripts/stow.fish