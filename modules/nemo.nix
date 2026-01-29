{ pkgs, lib, ... }:
{

 # Useful other development tools
  environment.systemPackages = with pkgs; [

		nemo-with-extensions
		nemo-preview
		nemo-emblems
		nemo-fileroller
		folder-color-switcher

		file-roller # gnome desktop archive manager


  ];

# https://discourse.nixos.org/t/changing-thunar-icon-theme/50178/8


	# necessary services
	services.gvfs.enable = true;
	services.tumbler.enable = true;





}
