{ config, pkgs, lib, username, hostName, ...}: {

   # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home-manager user configuration
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # basic git configuration
  programs.git = {
    enable = true;
    settings.user.name = "givtrah";
    settings.user.email = "givtrah@givtrah.org";
  };

  imports = [
  ./hyprland

  ./bash.nix
  ./kitty.nix

  ./gaming.nix
  ./flatpak.nix

#  ./features/r.nix

  ./cli-tools.nix
  ./fonts.nix

  ./gui-tools.nix

	./neovim/nvim.nix

  ./mimetypes.nix

  ]

  ++ lib.optional (builtins.elem hostName [ "taude" "taupa" ]) ./gaming.nix; 




 	programs.git.signing.format = "openpgp";  # Legacy: openpgp, new default: null. Changed in 26.05

# Packages that should be installed to the user profile.
  home.packages = with pkgs; 

  [

  ];



}
