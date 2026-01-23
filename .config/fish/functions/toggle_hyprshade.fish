function toggle_hyprshade
    if test "$hyprshade_enabled" = 1
        # turn it off
        hyprshade off
        set -U hyprshade_enabled 0
    else
        # turn it on
        set -U hyprshade_enabled 1

        if test "$hyprshade_mode" = 1
            hyprshade on blue-light-filter-low
            set -U hyprshade_mode 1
        else if test "$hyprshade_mode" = 2
            hyprshade on blue-light-filter-high
            set -U hyprshade_mode 2
        end
    end
end
