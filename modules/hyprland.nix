{ inputs, pkgs, ... }:
{

  # Enable Hyprland
  programs.hyprland = {
		enable = true;
		withUWSM = true; # with universal wayland session manager - better systemd integration
		xwayland.enable = true;
		portalPackage = pkgs.xdg-desktop-portal-hyprland ; 
	};

  # Hint electron apps to use Wayland
	
  xdg.menus.enable = true;
  xdg.mime.enable = true;


}
