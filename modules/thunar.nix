{ pkgs, ... }:
{

 # Useful other development tools
  environment.systemPackages = with pkgs; [



  ];

	programs.thunar = {
		enable = true;
		plugins = with pkgs.xfce; [
			thunar-volman
			thunar-vcs-plugin
			thunar-archive-plugin
			thunar-media-tags-plugin
		];
	};

	# necessary services
	services.gvfs.enable = true;
	services.tumbler.enable = true;


}
