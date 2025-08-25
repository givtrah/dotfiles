{ config, pkgs, ...}: {

  services.walker = {
    enable = true;
#    runAsService = true;

    # prevent it from trying to build from source
    package = pkgs.walker;

		};

# Nixify later (it's 100% possible), this will work for now

  home.file = {
    ".config/walker/config.toml" = {
      	source = ../../config/walker/config.toml;
    };
		".config/walker/themes/wal.css" = {
				source = ../../config/walker/themes/wal.css;
		};
		"config/walker/themes/wal.toml" = {
				source = ../../config/walker/themes/wal.toml;
		};
  };




  home.packages = with pkgs; 

  [


  ];


}
