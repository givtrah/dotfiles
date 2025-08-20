{ config, pkgs, ...}: {

  programs.walker = {
    enable = true;
    runAsService = true;

    # prevent it from trying to build from source
    package = pkgs.walker;

		};

# Nixify later (it's 100% possible), this will work for now

  home.file = {
    ".config/walker/" = {
      source = ../../config/walker;
      recursive = true;
    };
  };




  home.packages = with pkgs; 

  [


  ];


}
