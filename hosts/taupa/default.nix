# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
{
  system.stateVersion = "25.11"; # Depends on when host was installed, BEWARE

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disko-config.nix
      
      ../../modules/default.nix

      # This host is placed at work
      ../../modules/work.nix
    ];

  networking.hostName = "taupa"; # Define your hostname.
 
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # early modules
  boot.initrd.kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ]; # needed for potential passthrough
  # passthrough 2060 super
  # card sold boot.extraModprobeConfig ="options vfio-pci ids=10de:1f06,10de:10f9,10de:1ada,10de:1adb";
  # Enable KVM
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  # Enable clock+voltage config / power cap / fan control on AMD GPUs
	hardware.amdgpu.overdrive.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
 
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.networkmanager.wifi.powersave = false; # hopefully fixes bluetooth disconnect issues

  # mount additional drives (self created, not handled by disko)
   fileSystems."/mnt/vm" = {
   device = "/dev/disk/by-uuid/a6928e70-7552-4a8b-83cc-2834259c3e35";
   fsType = "btrfs";
   options = [ # If you don't have this options attribute, it'll default to "defaults" 
     # boot options for fstab. Search up fstab mount options you can use
     "noatime" # performance 
     "compress=zstd:3" # best performance from normal ssd
     "users" # Allows any user to mount and unmount
     "nofail" # Prevent system from failing if this drive doesn't mount
   ];
 };

  # Enable CUPS, ipp-usb and avahi to print documents (CUPS may not be necessary!).
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ gutenprint canon-cups-ufr2 ];
  services.printing.logLevel = "debug";
  services.ipp-usb.enable = true;
    services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # Firewall disabled by default
  networking.firewall.enable = false;


}

