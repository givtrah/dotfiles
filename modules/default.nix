{ config, lib, pkgs, username, hostName, ... }:

{
  # COMMON MODULES FOR ALL HOSTS
  imports = [
    # hardware or related
    ./sound.nix

    # General setup
    ./users.nix
    ./locale_tz.nix

    # Desktop environments or Window managers and related
    ./sddm.nix
    ./uwsm.nix
    ./plasma6.nix
    ./nemo.nix
  
    # Misc
#    ./llm.nix
    ./libs.nix
  ]

  ++ lib.optional (hostName == "taupa") ./llm.nix;


  # ;

  # Options considered always enabled regardless of host
  
  ############
  # HARDWARE #
  ############
  # Enable OpenGL - I can't think of a host that doesn't need this
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

		];

  ##################################
  # SERVICES  ENABLED ON ALL HOSTS #
  ##################################

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
  wireguard-tools
  sshfs
  unzip
  ];



}
