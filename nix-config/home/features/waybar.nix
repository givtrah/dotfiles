{ config, pkgs, ...}: {

# https://github.com/henrysipp/omarchy-nix/blob/main/modules/home-manager/waybar.nix

# OR

# https://github.com/JimJ92120/nixos-hyprland-module/blob/main/hyprland.nix

# Do as either one of those (first one prob preferred)

# Walker idea:
# https://git.allpurposem.at/mat/Computer/src/commit/2ec271dad1a54b7678644318504c4e76d8a3d204/home-manager/modules/walker.nix


 WAYBAR_CONFIG_DIRECTORY = ./files/waybar;


 file = lib.mkMerge [
          # copy resources from `./files`
          {
            ".config/waybar" = {
              source = WAYBAR_CONFIG_DIRECTORY;
              recursive = true;
            };
          }
          {
          # ensure scripts are executable
          {
            ".config/waybar/waybar.sh" = {
              source = WAYBAR_CONFIG_DIRECTORY + "/waybar.sh";
              executable = true;
            };
          }
          {
            ".config/waybar/modules/mediaplayer.py" = {
              source = WAYBAR_CONFIG_DIRECTORY + "/modules/mediaplayer.py";
              executable = true;
            };
          }
        ];
      };

      programs = {
        waybar = {
          enable = true;
        };


  home.packages = with pkgs; 

  [


  ];


}
