{ config, pkgs, username, ...}: {

  # user configuration
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # basic git configuration
  programs.git = {
    enable = true;
    settings.user.name = "givtrah";
    settings.user.email = "givtrah@givtrah.org";
  };

  imports = [
  ./hyprland/default.nix

  ./bash.nix
  ./kitty.nix

  ./gaming.nix
  ./dev.nix
  ./flatpak.nix

#  ./features/r.nix

  ./cli-tools.nix
  ./fonts.nix

  ./gui-tools.nix

	./neovim/nvim.nix

  ./mimetypes.nix

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
