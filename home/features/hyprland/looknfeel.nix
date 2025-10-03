{ config, pkgs, ...}: {

wayland.windowManager.hyprland.settings = {
		# should be sourced from configuration.nix
#    source=~/.cache/wal/colors-hyprland.conf 


# https://wiki.hyprland.org/Configuring/Variables/#general
		general = {
      gaps_in = 4;
      gaps_out = 8;

      border_size = 2;


    	# https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
      "col.active_border" = "$color14 $color3 45deg";
      "col.inactive_border" = "$color0";

    	# Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = true;

    	# Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;

      layout = "dwindle";
    };

		# https://wiki.hyprland.org/Configuring/Variables/#decoration
    decoration = {
      rounding = 10;
			rounding_power = 2;

    	# Change transparency of focused and unfocused windows
			active_opacity = 0.95;
			inactive_opacity = 0.85;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        # ignore_window = true; # UNSURE WHAT THIS DOES?
        color = "rgba(1a1a1aee)";
      };

    	# https://wiki.hyprland.org/Configuring/Variables/#blur
      blur = {
        enabled = true;
        size = 3;
        passes = 2;

        vibrancy = 0.1696;
      };
    };

		# https://wiki.hyprland.org/Configuring/Variables/#animations
    animations = {
      enabled = true; # yes, please :)

    	# Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];

      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
    		"workspaces, 1, 1.94, almostLinear, fade"
    		"workspacesIn, 1, 1.21, almostLinear, fade"
    		"workspacesOut, 1, 1.94, almostLinear, fade"
				# "workspaces, 0, 0, ease" # Omarchy Default
      ];
    };

		# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    dwindle = {
      pseudotile = true;
      preserve_split = true;
      force_split = 0; # 0 = follow mouse, 1 = always left, 2 = always right
    };

		# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    master = {
      new_status = "master";
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
			no_donation_nag = true;
			anr_missed_pings = 30; # time before getting the app not responding dialog box (default = 5)
    };
  };














  home.packages = with pkgs; 

  [


  ];


}
