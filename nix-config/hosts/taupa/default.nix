# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disko-config.nix

      ../../modules/work.nix
      ../../modules/common.nix

      ../../modules/users.nix
      ../../modules/locale_tz.nix
      ../../modules/sound.nix
      
      ../../modules/sddm.nix

      ../../modules/plasma6.nix
      ../../modules/sway.nix
      ../../modules/hyprland.nix
      ../../modules/cosmic.nix

      ../../modules/libs.nix

      ../../modules/hosts.nix

    ];

nixpkgs.config.permittedInsecurePackages = [
                "electron-29.4.6"
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
  # passthrough 2060 super
  boot.extraModprobeConfig ="options vfio-pci ids=10de:1f06,10de:10f9,10de:1ada,10de:1adb";
  # Enable KVM
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  
  # setup the ivshmem tmp file for looking glass
  systemd.tmpfiles.rules = [
  "f /dev/shm/looking-glass 0660 ohm qemu-libvirtd -"
  ];


  # Enable hugepages for better (windows) VM performance
  #  boot.kernelParams = ["hugepagesz=1G" "hugepages=24"]; # remember to enable in libvirt... 


  # mount additional drives (that I created myself)
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


# nixpkgs.config.permittedInsecurePackages = [
#               # "mailspring-1.12.0"
#              ];


  networking.hostName = "taupa"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  

  
  # Enable CUPS, ipp-usb and avahi to print documents (CUPS may not be necessary!).
  services.printing.enable = true;
  services.ipp-usb.enable = true;
  services.avahi.enable = true;

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
  system.stateVersion = "23.11"; # Did you read the comment?

}

