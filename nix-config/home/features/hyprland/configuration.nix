{ config, pkgs, ...}: {

  imports = [
    ./autostart.nix
    ./bindings.nix
    ./envs.nix
    ./input.nix
    ./looknfeel.nix
		./monitors.nix
    ./windows.nix
  ];

	wayland.windowManager.hyprland.sourceFirst = true;

  wayland.windowManager.hyprland.settings = {
    # Default applications (if you want to define again elsewhere to change, use $.. = lib.mkDefault "program")

		source = "~/.cache/wal/colors-hyprland.conf";
		

		# NEEDS TO BE FIXED
		# SEE
		# https://discourse.nixos.org/t/install-shell-script-on-nixos/6849
		# https://ertt.ca/nix/shell-scripts/
		# using https://github.com/numtide/flake-utils
		"$random_wall" = "~/.dotfiles/nix-config/home/features/hyprland/scripts/wall-random.sh";

		"$terminal" =  "kitty";
    "$fileManager" = "dolphin --new-window";
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
