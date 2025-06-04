# Machine specific configuration (often modified from auto-generated configuration.nix)

{ inputs, lib, pkgs, nixpkgs, nixos-cosmic, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include support for apple silicon (M* cpus)
#      inputs.apple-silicon.nixosModules.apple-silicon-support

      # modules 

      ../../modules/common.nix
      ../../modules/sound.nix
      ../../modules/locale_tz.nix
      ../../modules/sddm.nix
      ../../modules/plasma6.nix
      ../../modules/hyprland.nix
      ../../modules/users.nix
     ../../modules/cosmic.nix
      ../../modules/distrobox.nix
      ../../modules/libs.nix
      ../../modules/sway.nix
      ../../modules/hosts.nix
    ];

#  nixpkgs.config.allowBroken = true; # BAD IDEA! needed for compatibility with x86 as rstudio is currently broken on aarch64

  # BOOT LOADER + KERNEL PARAMS

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # kernel parameters
  # Fix Fn keys = F1-F12 is basic mode
  boot.kernelParams = [ "hid_apple.fnmode=2" ];

  # HARDWARE SPECIFIC STUFF

  # enable GPU support and audio
  hardware.asahi.useExperimentalGPUDriver = true;
  hardware.asahi.experimentalGPUInstallMode = "replace";
  hardware.asahi.setupAsahiSound = true;


  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd"; # zstd default
    memoryPercent = 50; # 50 default
    priority = 100; # 5 default, higher = used first
  };

  # 8 GB ssd swap for insane overflow purposes
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8*1024;
    priority = 1; # default null = kernel decides, probably not optimal!
  } ];


  # displaylink
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Use latest kernel - already defined in apple-silicon-support
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # Define hostname
  networking.hostName = "taumac"; 

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking.firewall.checkReversePath = false;

  #  networking.wireless.iwd = {
  #    enable = true;
  #    settings.General.EnableNetworkConfiguration = true;
  #  };

  

  # System specific X11 / display components Enable the X11 windowing system.

  services.xserver.synaptics.palmDetect = true; 

#  services.desktopManager.cosmic.enable = true;
#  services.displayManager.cosmic-greeter.enable = true;  
  

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

