{ inputs, pkgs, ... }:
{
# needed for sway to work, might interfere with other things?
  security.polkit.enable = true; # probably cannot be moved to home-manager!
	
	programs.uwsm = {
		enable = true;
		waylandCompositors = {
			sway = {
				prettyName = "Sway";
				comment = "Sway compositor managed by UWSM";
				binPath = "/run/current-system/sw/bin/sway";
			};
		};
	};

  # Hint electron apps to use Wayland
	
  xdg.menus.enable = true;
  xdg.mime.enable = true;


}
