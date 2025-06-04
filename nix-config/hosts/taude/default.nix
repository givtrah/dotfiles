# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disko-config.nix

      ../../modules/common.nix
      ../../modules/libs.nix
      ../../modules/users.nix
      ../../modules/locale_tz.nix
      ../../modules/sound.nix
      ../../modules/sddm.nix
      ../../modules/plasma6.nix

      ../../modules/cosmic.nix

      #      ../../modules/ollama.nix
      
      #      ../../modules/sway.nix
      ../../modules/distrobox.nix
#      ../../modules/dropbox.nix

      ../../modules/hyprland.nix

    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # 2060 super passthrough
#  gpuIDs = [
#    "10de:1f06" # Graphics
#    "10de:10f9" # Audio
#    "10de:1ada" # USB controller
#    "10de:1adb" # Serial bus controller
#  ];

  # early modules
  boot.initrd.kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ];

  # disable ethernet energy efficiency (causes link drops...)

# passthrough 2060 super
#  boot.extraModprobeConfig ="options vfio-pci ids=10de:1f06,10de:10f9,10de:1ada,10de:1adb";
  # Enable KVM
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  
  # setup the ivshmem tmp file for looking glass
#  systemd.tmpfiles.rules = [
#  "f /dev/shm/looking-glass 0660 ohm qemu-libvirtd -"
#  ];


  # Enable hugepages for better (windows) VM performance
  # Disable ethernet energy efficiency (causes link drops..)
  #  boot.kernelParams = ["hugepagesz=1G" "hugepages=24" "igb.EEE=0"]; # remember to enable in libvirt... 


  # mount additional drives (that I created myself)

#  fileSystems."/mnt/emu8tb" =
#    { device = "/dev/disk/by-uuid/52b69fea-5db0-429c-bb26-01f6d9d1ed1f";
#      fsType = "btrfs";
#      options = [ "compress=zstd" "noatime" "discard=async" ];
#    };

#  fileSystems."/mnt/emu" =
#    { device = "/dev/disk/by-uuid/81093fa1-9e80-4b4e-915d-0c67e5a08fdf";
#      fsType = "btrfs";
#      options = [ "compress=zstd" "noatime" "discard=async" ];
#    };





# nixpkgs.config.permittedInsecurePackages = [
#               # "mailspring-1.12.0"
#              ];


  networking.hostName = "taude"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.


  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  #  services.blueman.enable = true; # should probably not be enabled when using KDE, but doesn't matter much except giving an additional tray icon.

  # Enable CUPS, ipp-usb and avahi to print documents (CUPS may not be necessary!).
  services.printing.enable = true;
  services.ipp-usb.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

#  services.printing.drivers = [ pkgs.hplip ];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Virt-manager and Qemu - remember ovmf package for fake secure boot
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
	packages = [(pkgs.OVMF.override {
	  secureBoot = true;
	  tpmSupport = true;
	  }).fd];
	};
      };
    };
  programs.virt-manager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

