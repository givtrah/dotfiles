{ config, pkgs, ...}: {



	wayland.windowManager.hyprland.settings = {

		#############
		### INPUT ###
		#############
    # https://wiki.hyprland.org/Configuring/Variables/#input
    input = {
      kb_layout = "dk";
      # kb_variant =
      # kb_model =
			# kb_options = compose:caps;
      # kb_rules =

      follow_mouse = 1;

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
				disable_while_typing = true;
        natural_scroll = true;
				clickfinger_behavior = true;
      };
    };

		# https://wiki.hyprland.org/Configuring/Variables/#gestures
		gestures = {
    	workspace_swipe = false;
		};
  };


  home.packages = with pkgs; 

  [


  ];


}
