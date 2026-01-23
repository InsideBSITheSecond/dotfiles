#!/usr/bin/env fish

# this is powered by fish functions.
# also the shader files must be installed (not the case by default rn)

# ensure default if unset
set -q hyprshade_enabled; or set -U hyprshade_enabled 1
set -q hyprshade_mode; or set -U hyprshade_mode 1

if test "$hyprshade_enabled" = "1"
    if test "$hyprshade_mode" = "1"
        hyprshade on blue-light-filter-low
    else test "$hyprshade_mode" = "2"
        hyprshade on blue-light-filter-high
    end
else
    hyprshade off
end