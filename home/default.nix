{ config, pkgs, zotero-nix, ...}: {

  # user configuration
  home.username = "ohm";
  home.homeDirectory = "/home/ohm";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # basic git configuration
  programs.git = {
    enable = true;
    settings.user.name = "givtrah";
    settings.user.email = "givtrah@givtrah.org";
  };

  imports = [
  #  inputs.nix-flatpak.homeManagerModules.nix-flatpak	 

  ./features/gaming.nix


  ./features/hyprland.nix

  ./features/bash.nix
  ./features/terminals.nix

  ./features/dev.nix
  ./features/flatpak.nix

#  ./features/r.nix
  ./features/office.nix

  ./features/browsers.nix
  ./features/cli-tools.nix
  ./features/fonts.nix

  ./features/desktop.nix
  ./features/qemu.nix

		./features/nvim.nix

   ./features/mimetypes.nix

#  ./features/swayfx.nix - don't do both hyprland and swayfx! choose one!
   
  ];

#  programs.dconf.enable = true; Should be done in a module

# Use `dconf watch /` to track stateful changes you are doing, then set them here.


    dconf.settings."org/gtk/settings/file-chooser" = {
    sort-directories-first = true;
   };

# various fixes due to new home-manager versions - e.g. legacy fixes

	gtk.gtk4.theme = config.gtk.theme; # Legacy: config.gtk.theme, new default: null. Changed in 26.05
 	programs.git.signing.format = "openpgp";  # Legacy: openpgp, new default: null. Changed in 26.05




# Packages that should be installed to the user profile.
  home.packages = with pkgs; 

  [

  ];



}
