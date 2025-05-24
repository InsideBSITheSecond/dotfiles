#!/bin/fish

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Final touch of the installation, it will backup old configs 
# and symlink the ones from the repo
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

mv ~/.config/hypr ~/.config/hypr.bkp
mv ~/.config/kitty ~/.config/kitty.bkp
mv ~/.config/rofi ~/.config/rofi.bkp
mv ~/.config/waybar ~/.config/waybar.bkp

stow -t ~/.config .config -v

hyprctl reload