function toggle_hyprshade
    if test "$hyprshade_enabled" = "1"
        # turn it off
        hyprshade off
        set -U hyprshade_enabled 0
    else
        # turn it on
        hyprshade on blue-light-filter
        set -U hyprshade_enabled 1
    end
end
