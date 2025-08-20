{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
    

  virtiofsd

  OVMF # for qemu secure boot emulation
#  looking-glass-client # for windows VM
  swtpm # software TPM






  ]

  ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ ]
  else
    (if (pkgs.system == "x86_64-linux")
#      then [ looking-glass-client ] # does not compile 2024-12-29
      then [ ]
  else []));
}
