{ config, pkgs, ...}: {

  programs.firefox = {
    enable = true;
      languagePacks = [ "en-US" ];

#    preferences = { 
#      "widget.use-xdg-desktop-portal.file-picker" = 1;
#    };
#    override = {
#      pipewireSupport = true;
#    };
  };




  home.packages = with pkgs; 

  [

  # browsers
  librewolf
  floorp

  brave
  chromium

  ]

  ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ ]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ # microsoft-edge                        # Edge unmaintained as of 2025-05-27
             google-chrome ]
      else []));




}
