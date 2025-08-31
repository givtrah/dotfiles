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

		source = "~/.cache/wal/colors-hyprland.conf";
		

		# NEEDS TO BE FIXED
		# SEE
		# https://discourse.nixos.org/t/install-shell-script-on-nixos/6849
		# https://ertt.ca/nix/shell-scripts/
		# using https://github.com/numtide/flake-utils
		"$random_wall" = "~/.dotfiles/home/features/hyprland/scripts/wall-random.sh";

		"$terminal" =  "kitty";
    "$filemanager" = "dolphin --new-window";
    "$browser" = "firefox";
		"$menu" = "walker";
    "$music" = "amarok"; # needs amarok
    "$passwordManager" = "bitwarden"; #needs bitwarden-desktop
    "$messenger" = "signal-desktop"; #needs signal-desktop
#    "$webapp" = lib.mkDefault "$browser --app"; # examine omarchy to see what's going on here

		};




home.packages = with pkgs; 

  [


  ];


}
