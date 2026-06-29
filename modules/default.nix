{ config, lib, pkgs, username, ... }:

{
  # COMMON MODULES FOR ALL HOSTS
  imports = [
    # hardware

    ./users.nix
    ./locale_tz_nix
    ./sound.nix
    ./sddm.nix
    ./plasma6.nix
    ./uwsm.nix
    ./llm.nix
    ./libs.nix
    ./hosts.nix
    ./nemo.nix
  ];

  # Options considered always enabled regardless of host
  
  ############
  # HARDWARE #
  ############
  # Enable OpenGL
  hardware.graphics.enable = true;


  ################
  # NIX SETTINGS #
  ################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental nix commands and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Fix download buffer issues
  nix.settings.download-buffer-size = 524288000;

  # allowed users (allowed to interact with nix daemon, this may be the default setting)
  nix.settings.allowed-users = [ "*" ];
  # trusted users
  nix.settings.trusted-users = [ "root" username ];

  # SECURITY OVERRIDES (BEWARE!)
  nixpkgs.config.permittedInsecurePackages = [
  #  "SDL_ttf-2.0.11" 
	#	"electron-38.8.4" # for RStudio 2026-04-04
		];




  ############
  # SERVICES #
  ############

  # Enable blueman service (bluetooth gui/applet) instead of using it as a package
  services.blueman.enable = true;

  # Peridodically trim SSDs
  services.fstrim.enable = true;
  
  # Enable periodic scrub on btrfs (default once per month) as well as periodic trim (default once per week)
  # NOTE: If host does not have btrfs drives, use an override to disable: services.btrfs.autoScrub.enable = lib.mkForce false;
  services.btrfs.autoScrub.enable = true;

  # Enable timesync (ntp) using default (nix) servers
  services.timesyncd.enable = true;

  # Enable tailscale
  services.tailscale.enable = true;

  # Enable flatpaks
  services.flatpak.enable = true;

  # increase watchable files (to stop dropbox/maestral from blinking...)
  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = "4194304"; };




  # Fix missing window decorations and terrible icon themes for gnome programs outside of gnome
  # also needs package gnome.adwaita-icon-theme

  programs.dconf.enable = true;


  environment.variables.EDITOR = "nvim"; # default editor is neovim
  
  # Make BASH the default user shell
  users.defaultUserShell = pkgs.bash;

programs.bash = {
    enable = true;
    completion.enable = true;
    };

  # Setup xdg desktop portals (assuming default install is KDE?!?!? or? fix me)

	# Garbage collection

	nix.gc = {
  	automatic = true;
  	dates = "weekly";
  	options = "--delete-older-than 14d";
	};

	# Automatic optimization of the nix store periodically
	nix.optimise.automatic = true;	

  # Packages ALL systems should ALWAYS have installed, to be used for ALL users - e.g. also available to root

  environment.systemPackages = with pkgs; [
  git # git must be first when using flakes as it clones its dependencies using git
  gh  # github helper
  curl 
  wget

  cups-browsed

  vim # so we at least have vi - for neovim, see home-manager

  tailscale
  rclone

  adwaita-icon-theme # for dconf enable above, fix gnome window decorations

  wireguard-tools

  sshfs

  unzip

  ];



}
