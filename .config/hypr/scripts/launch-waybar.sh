#!/bin/bash

CONFIG_FILES="$HOME/.config/waybar/config.jsonc \
    $HOME/.config/waybar/base-modules.jsonc \
    $HOME/.config/waybar/style.scss \
    $HOME/.config/waybar/colors.scss" 

trap "killall waybar" EXIT

while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    sassc $HOME/.config/waybar/style.scss $HOME/.config/waybar/style.css
    killall waybar
done
