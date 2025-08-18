{ config, pkgs, ...}: {

##############################
### MONITORS  & Workspaces ###
##############################

# See https://wiki.hyprland.org/Configuring/Monitors/
# monitor=,preferred,auto,auto

	let hostName = config.networking.hostName;
	
	monitorSettings =
		builtins.switch hostName {
		
			"taude" = [
			"DP-1, 3840x2160, 0x0, 1.5"
			"DP-2, 3840x2160, 2560x0, 1.5"
		];

			"taupa" = [
				"DP-2, 3840x2160, 0x0, 1.5"
				"DP-3, 3840x2160, 2560x-560, 1.5, transform, 1"
			];
		
			"taumac" = [
				",preferred,auto,auto"
			];
			
			default = [
				",preferred,auto,auto"
			];
		};


workspaceSettings =
    builtins.switch hostName {
      "taude" = [
        "1,persistent,monitor:DP-1"
        "2,persistent,monitor:DP-1"
        "3,persistent,monitor:DP-1"
        "4,persistent,monitor:DP-1"
        "5,persistent,monitor:DP-1"
        "6,persistent,monitor:DP-1"
        "7,persistent,monitor:DP-1"
        "8,persistent,monitor:DP-2"
        "9,persistent,monitor:DP-2"
        "10,persistent,monitor:DP-2"
        "1,default:true,monitor:DP-1"
        "8,default:true,monitor:DP-2"
      ];
      "taupa" = [
        "1,persistent,monitor:DP-2"
        "2,persistent,monitor:DP-2"
        "3,persistent,monitor:DP-2"
        "4,persistent,monitor:DP-2"
        "5,persistent,monitor:DP-2"
        "6,persistent,monitor:DP-2"
        "7,persistent,monitor:DP-2"
        "8,persistent,monitor:DP-3"
        "9,persistent,monitor:DP-3"
        "10,persistent,monitor:DP-3"
        "1,default:true,monitor:DP-2"
        "8,default:true,monitor:DP-3"
      ];
      "taumac" = [
	      "1,persistent,monitor:eDP-1"
        "2,persistent,monitor:eDP-1"
        "3,persistent,monitor:eDP-1"
        "4,persistent,monitor:eDP-1"
        "5,persistent,monitor:eDP-1"
        "6,persistent,monitor:eDP-1"
        "7,persistent,monitor:eDP-1"
        "8,persistent,monitor:DP-2" # BEWARE, DISPLAYLINK MONITOR IS CALLED?!?!?
        "9,persistent,monitor:DP-2"
        "10,persistent,monitor:DP-2"
        "1,default:true,monitor:eDP-1"
        "8,default:true,monitor:DP-2"				
      ];
      # A default case
      default = [
      ];
    };

	in
		{
  		wayland.windowManager.hyprland.settings = {
    		monitor = monitorSettings;
    		workspace = workspaceSettings;
  		};
		};

}
