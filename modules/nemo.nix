{ pkgs, ... }:
{

 # Useful other development tools
  environment.systemPackages = with pkgs; [

		nemo-with-extensions
		nemo-preview
		nemo-emblems
		nemo-fileroller
		folder-color-switcher

		file-roller # gnome desktop archive manager

		xdg-utils

  ];

# https://discourse.nixos.org/t/changing-thunar-icon-theme/50178/8


	# necessary services
	services.gvfs.enable = true;
	services.tumbler.enable = true;


	gtk = { 
		enable = true;
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme;
		};

		theme = lib.mkForce {
			name = "Nightfox-Dark";
			package = pkgs.nightfox-gtk-theme;
		};




}
