{ inputs, pkgs, ... }:
{

  programs.uwsm = {
    enable = true;

    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/hyprland";
        };

      mango = {
        prettyName = "MangoWM";
        comment = "Mango Window Manager managed by UWSM";
        binPath = "/run/current-system/sw/bin/mango"; # CHECK!
      };
    };
  };


  programs.mango.enable = true;







  # Enable Hyprland
  programs.hyprland = {
		enable = true;
# I use uwsm above...		withUWSM = true; # with universal wayland session manager - better systemd integration
		xwayland.enable = true;
		portalPackage = pkgs.xdg-desktop-portal-hyprland ; 
	};


  # required for noctalia

  services.tuned.enable = true;
  services.upower.enable = true;

  # Hint electron apps to use Wayland
	
  xdg.menus.enable = true;
  xdg.mime.enable = true;


}
