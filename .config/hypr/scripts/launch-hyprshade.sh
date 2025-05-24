#!/usr/bin/env fish
# ensure default if unset

set -q hyprshade_enabled; or set -U hyprshade_enabled 1

if test "$hyprshade_enabled" = "1"
    hyprshade on blue-light-filter
else
    hyprshade off
end