{ config, pkgs, lib, username, hostName, ...}: {

   # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Needed settings due to old Home-Manager StateVersion for some hosts
 	programs.git.signing.format = "openpgp";  # Legacy: openpgp, new default: null. Changed in 26.05

  # Home-manager user configuration
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Basic git configuration
  programs.git = {
    enable = true;
    settings.user.name = "givtrah";
    settings.user.email = "givtrah@givtrah.org";
  };

# setup TS hosts from sops
#home.file.".hosts".source = "/run/secrets/hosts";
#home.sessionVariables = {
#    HOSTALIASES = "${config.home.homeDirectory}/.hosts";
#  };


  imports = [
  ./hyprland

  ./bash.nix
  ./kitty.nix

  ./flatpak.nix

  ./r.nix

  ./cli-tools.nix
  ./fonts.nix

  ./gui-tools.nix

	./neovim

  ./mimetypes.nix

  ./agents.nix

  ]

  # Gaming hosts
  ++ lib.optional (builtins.elem hostName [ "taude" "taupa" ]) ./gaming.nix

  ++ lib.optional (builtins.elem hostName [ "taumac" ]) ./gaming-aarch64.nix
  ; 

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [ ]; 

}
