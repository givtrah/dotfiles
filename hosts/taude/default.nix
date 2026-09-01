# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, ... }:{

  system.stateVersion = "25.11"; # Depends on when host was installed, BEWARE!

  imports =
    [ ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disko-config.nix

      ../../modules/default.nix

 #     ../../modules/work.nix
    ];

  networking.hostName = "taude"; # Define your hostname.

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Disable nvme autonomous power states (e.g. power saving) to prevent driver failure
  boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];


  # early modules
  boot.initrd.kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ]; # needed for potential passthrough

  # disable ethernet energy efficiency (causes link drops...)
  # might need to be done still

  # Enable KVM and sg (for cdrom/dvd/bluray)
  boot.kernelModules = [ "kvm-amd" "kvm-intel" "sg" "ntsync" ]; #consider ntsync in the future... (for Wine, causes crashes in steam?)
  
  # Enable mounting nfs at boot?
	boot.supportedFilesystems = [ "nfs" ];
  
  # Enable clock+voltage config / power cap / fan control on AMD GPUs
	hardware.amdgpu.overdrive.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

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

  # Enable CUPS, ipp-usb and avahi to print documents (CUPS may not be necessary!).
  services.printing.enable = true;
  services.ipp-usb.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # DBUS service to enable configuring gaming mice
	services.ratbagd.enable = true;
  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # Firewall disabled by default
  networking.firewall.enable = false;

}

