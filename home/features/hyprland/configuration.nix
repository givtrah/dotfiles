{ config, pkgs, ...}: {

  imports = [
    ./envs.nix
    ./autostart.nix
    ./bindings.nix
    ./input.nix
    ./looknfeel.nix
    ./monitors.nix
    ./windows.nix
  ];

	# Load user config first, then system-wide defaults, not working?
#	wayland.windowManager.hyprland.sourcefirst = true;

  wayland.windowManager.hyprland.settings = {
    # Default applications (if you want to define again elsewhere to change, use $.. = lib.mkDefault "program")
		"$color14" = "rgba(212,154,156,1.0)";
		"$color3" = "rgba(204,61,82,1.0)";
		"$color0" = "rgba(7,16,31,1.0)";
		source = "~/.cache/wal/colors-hyprland.conf";
		

		# NEEDS TO BE FIXED
		# SEE
		# https://discourse.nixos.org/t/install-shell-script-on-nixos/6849
		# https://ertt.ca/nix/shell-scripts/
		# using https://github.com/numtide/flake-utils
		"$random_wall" = "~/.dotfiles/home/features/hyprland/scripts/wall-random.sh";

		"$terminal" =  "kitty";
#    "$filemanager" = "dolphin --new-window";
		"$filemanager" = "nemo ~/Dropbox";
    "$browser" = "firefox";
#    "$menu" = "pkill wofi || wofi --show drun";
#		"$menu" = "wofi --show drun";
		"$menu" = "rofi -show drun";
    "$music" = "amarok"; # needs amarok
    "$passwordManager" = "bitwarden"; #needs bitwarden-desktop
    "$messenger" = "signal-desktop"; #needs signal-desktop
#    "$webapp" = lib.mkDefault "$browser --app"; # examine omarchy to see what's going on here

		};




home.packages = with pkgs; 

  [


  ];


}
