{ inputs, pkgs, ... }:
{

  # Enable Hyprland
  programs.hyprland.enable = true;
  # Hint electron apps to use Wayland

  xdg.menus.enable = true;
  xdg.mime.enable = true;


}
