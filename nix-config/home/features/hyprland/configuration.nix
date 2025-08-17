{ config, pkgs, ...}: {




  imports = [
    ./autostart.nix
    ./bindings.nix
    ./envs.nix
    ./input.nix
    ./looknfeel.nix
		./monitors.nix
    ./windows.nix
  ];
  wayland.windowManager.hyprland.settings = {
    # Default applications (if you want to define again elsewhere to change, use $.. = lib.mkDefault "program")
    "$terminal" =  "kitty";
    "$fileManager" = "dolphin";
    "$browser" = "firefox";
    "$music" = "amarok"; # needs amarok
    "$passwordManager" = "bitwarden"; #needs bitwarden-desktop
    "$messenger" = "signal-desktop"; #needs signal-desktop
#    "$webapp" = lib.mkDefault "$browser --app"; # examine omarchy to see what's going on here




home.packages = with pkgs; 

  [


  ];


}
