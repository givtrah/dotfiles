# Machine specific configuration (modified from auto-generated configuration.nix)


{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
#	<nixos-hardware/microsoft/surface/surface-laptop-amd>
      ./hardware-configuration.nix

# may or may  not be needed here as well, do test
      inputs.nixos-hardware.nixosModules.microsoft-surface-laptop-amd

      ../../modules/common.nix                                                                      
      ../../modules/sound.nix                                                                       
      ../../modules/locale_tz.nix                                                                   
      ../../modules/sddm.nix                                                                        
      ../../modules/plasma6.nix                                                                     
      ../../modules/hyprland.nix                                                                    
      ../../modules/users.nix                                                                       
      ../../modules/distrobox.nix                                                                   
      ../../modules/libs.nix                                                                        
      ../../modules/hosts.nix                                                                       
      ../../modules/nemo.nix                                                                        

    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  boot.initrd.availableKernelModules = [
    # needed for keyboard to work at boot for surface laptop 4
    "surface_aggregator"
    "surface_aggregator_registry"
    "surface_aggregator_hub"
    "surface_hid_core"
    "8250_dw"
    "surface_hid"
    # end keyboard boot stuff

  ];

  boot.initrd.luks.devices."luks-c68d0fe3-b7a6-46ce-b5d5-8bd11f64be73".device = "/dev/disk/by-uuid/c68d0fe3-b7a6-46ce-b5d5-8bd11f64be73";
  networking.hostName = "tausurf"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false; # needed for tailscale

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

#  services.xserver.videoDrivers = [ "displaylink" "modesetting" ]; - should be enabled later

  # Enable touchpad support (enabled default in most desktopManager).

  services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget

	vim
	btop
	surface-control
	fastfetch
	git
	gh


  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
