{ config, pkgs, zotero-nix, ...}: {

  # user configuration
  home.username = "ohm";
  home.homeDirectory = "/home/ohm";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # basic git configuration
  programs.git = {
    enable = true;
    userName = "givtrah";
    userEmail = "givtrah@givtrah.org";
  };

  imports = [
  #  inputs.nix-flatpak.homeManagerModules.nix-flatpak	 

#  ./features/gaming.nix

  ./features/bash.nix
  ./features/terminals.nix

  ./features/dev.nix
  ./features/flatpak.nix

  ./features/r.nix
  ./features/office.nix

  ./features/browsers.nix
  ./features/cli-tools.nix
  ./features/fonts.nix

  ./features/desktop.nix
  ./features/qemu.nix


  ./features/nvim-fix.nix
  ./features/nvim-lazy.nix

  ./features/swayfx.nix
   
  ./features/hyprland.nix
#  ./features/swayfx.nix

  ];

#  programs.dconf.enable = true; Should be done in a module

# Use `dconf watch /` to track stateful changes you are doing, then set them here.


    dconf.settings."org/gtk/settings/file-chooser" = {
    sort-directories-first = true;
   };


# Packages that should be installed to the user profile.
  home.packages = with pkgs; 

  [

  ];



}
