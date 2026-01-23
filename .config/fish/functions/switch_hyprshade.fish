function switch_hyprshade
	if test "$hyprshade_enabled" = 1
		if test "$hyprshade_mode" = 1
			hyprshade on blue-light-filter-high
        	set -U hyprshade_mode 2
		else if test "$hyprshade_mode" = 2
			hyprshade on blue-light-filter-low
        	set -U hyprshade_mode 1
		end
	end
end