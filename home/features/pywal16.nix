{ config, pkgs, ...}: {

  programs.pywal = {
    enable = true;
    # use pywal16
    package = pkgs.pywal16;

		};

# Nixification NOT possible, question is if the kitty-colors.conf is needed?

#  home.file = {
#    ".config/wal/" = {
#      source = ../../config/wal;
#      recursive = true;
#    };
#  };




  home.packages = with pkgs; 

  [


  ];


}
