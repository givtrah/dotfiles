{ config, lib, pkgs, ... }:

{
  

  # Options considered always enabled regardless of host

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flatpaks
  services.flatpak.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "SDL_ttf-2.0.11" ];

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Enable experimental nix commands and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # allowed users (allowed to interact with nix daemon, this may be the default setting)
  nix.settings.allowed-users = [ "*" ];

  # Enable periodic scrub on btrfs (default once per month) as well as periodic trim (default once per week)

  services.btrfs.autoScrub.enable = true;
  services.fstrim.enable = true;

  # Enable timesync (ntp) using default (nix) servers

  services.timesyncd.enable = true;


  # Enable tailscale
  services.tailscale.enable = true;


  # fix non-nix programs not working (taken from https://nix.dev/guides/faq.html) 
#  programs.nix-ld.enable = true;
#  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    # consider using "steam-run" to run non-nix programs
#  ]; 


  # increase watchable files (to stop dropbox from blinking...)
  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = "1048576"; };




  # Fix missing window decorations and terrible icon themes for gnome programs outside of gnome
  # also needs package gnome.adwaita-icon-theme

  programs.dconf.enable = true;

  nix.settings.trusted-users = [ "root" "ohm" ];

  environment.variables.EDITOR = "nvim"; # default editor is neovim
  

# FORCE libreoffice (non-QT!) / all GTK apps.. to use a white theme! for my sanity...
#  environment.variables.GTK_THEME = "Adwaita"; 
  environment.sessionVariables = {
    GTK_THEME = "Adwaita";
    };


  # Make BASH the default user shell
  users.defaultUserShell = pkgs.bash;

programs.bash = {
    completion.enable = true;
    # TODO add your custom bashrc here
#    bashrcExtra = ''
#      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
#    ''; - ONLY WORKS IN HOME-MANAGER

    # set some default aliases
    shellAliases = {
      vi = "nvim"; # the one editor!
      sudo="sudo "; # fix aliases not working using sudo - the space means carry over aliases
    };
  };

  # Setup xdg desktop portals (assuming default install is KDE?!?!? or? fix me)

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Packages ALL systems should ALWAYS have installed, to be used for ALL users (users + root)

  environment.systemPackages = with pkgs; [
  git # git must be first when using flakes as it clones its dependencies using git
  gh
  curl
  wget

  neovim
  vim

  tailscale
  rclone
  # qutebrowser # backup browser just in case!

  adwaita-icon-theme # for dconf enable above, fix gnome window decorations

  wireguard-tools

  cmake
  sshfs

  # needed systemwide packages for neovim kickstart
  gnumake
  unzip
  gcc
  gcc14
  ripgrep
  fd

  ];



}
