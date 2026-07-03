{ pkgs, config, lib, options, ... }:

{
  # Disable timesyncd so it stops trying to evaluate during compilation
  services.timesyncd.enable = false;

  # Enable Chrony to handle the secret NTP server from SOPS
  services.chrony = {
    enable = true;
    
    # Chrony accepts the string path natively. Nix won't try to read the file contents now!
    extraConfig = ''
      include ${config.sops.secrets.work_timeserver.path}
    '';
  };


# LOOK at home.nix for how to mount nfs	

# Network shares









}

