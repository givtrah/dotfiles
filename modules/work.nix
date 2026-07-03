{ pkgs, config, lib, options, ... }:

{
  # 1. Fully disable timesyncd so it stops trying to evaluate during compilation
  services.timesyncd.enable = false;

  # 2. Enable Chrony to handle the secret file at runtime
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

