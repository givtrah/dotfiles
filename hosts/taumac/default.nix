{ inputs, config, lib, pkgs, ... }:{

  system.stateVersion = "24.05"; # Did you read the comment?

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include support for apple silicon (M* cpus)
      inputs.apple-silicon.nixosModules.apple-silicon-support

      ../../modules/default.nix

    ];

  networking.hostName = "taumac"; # Define your hostname.

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # kernel parameters
  # Fix Fn keys = F1-F12 is basic mode
  boot.kernelParams = [ "hid_apple.fnmode=2" ];

  # HARDWARE SPECIFIC STUFF


  # enable Asahi hardware and audio
  hardware.asahi.enable = true;
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


  # displaylink, not able to compile since 2025-08-30 kernel 6.15.10-asahi
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking.firewall.checkReversePath = false;


  services.xserver.synaptics.palmDetect = true; 

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


}

