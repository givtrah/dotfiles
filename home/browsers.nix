{ config, pkgs, ...}: {

  programs.firefox = {
    enable = true;
      languagePacks = [ "en-US" ];
      configPath = "${config.xdg.configHome}/mozilla/firefox";

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
#  librewolf
  floorp-bin

  brave
  chromium

  ]

  ++
   
    (if (pkgs.stdenv.hostPlatform.system == "aarch64-linux")
    then [ ]
  else
    (if (pkgs.stdenv.hostPlatform.system == "x86_64-linux")
      then [ # microsoft-edge                        # Edge unmaintained as of 2025-05-27
             google-chrome ]
      else []));




}
