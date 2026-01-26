{ pkgs, ... }:
{

 # Useful other development tools
  environment.systemPackages = with pkgs; [

		nemo-with-extensions
		nemo-python
		nemo-preview
		nemo-emblems
		nemo-seahorse
		nemo-fileroller
		folder-color-switcher

  ];

	# necessary services
	services.gvfs.enable = true;
	services.tumbler.enable = true;


}
