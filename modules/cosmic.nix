{ config, pkgs, inputs, lib, ... }: {


	services.displayManager.cosmic-greeter = {
		enable = true;
		package = pkgs.cosmic-greeter;
	};

	services.desktopManager.cosmic = {
		enable = true;
		xwayland.enable = true;
	};

	environment.sessionVariables = {
		XCURSOR_SIZE="24";
    NIX_AUTO_RUN = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_ENABLE_XINPUT2 = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    COSMIC_DATA_CONTROL_ENABLED = "1";
    XDG_DESKTOP_DIR = "$HOME/Desktop";
    XDG_DOCUMENTS_DIR = "$HOME/Documents";
    XDG_DOWNLOAD_DIR = "$HOME/Downloads";
    XDG_MUSIC_DIR = "$HOME/Music";
    XDG_PICTURES_DIR = "$HOME/Pictures";
    XDG_PUBLICSHARE_DIR = "$HOME/Public";
    XDG_TEMPLATES_DIR = "$HOME/Templates";
    XDG_VIDEOS_DIR = "$HOME/Videos";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-cosmic
      ];
    config = {
      common = {
      default = [ "cosmic" ];
      };
    };
  };

  # Hint electron apps to use wayland (might not be needed in cosmic.. need to test)
	xdg.menus.enable = true;
	xdg.mime.enable = true;


}
