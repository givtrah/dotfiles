{ config, pkgs, username, ... }:

{
  sops = {
    # This is the default secret file for everything in this module
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

#    Not needed, it should inherit the info from system-wide SOPS config
#    age.keyFile = "/var/lib/sops-nix/keys.txt"; 
   

    # Personal user space secrets definitions
    secrets = {
      # Deploys your customized host mapping routes to ~/.ssh/config
      ssh_config = {
        path = "${config.home.homeDirectory}/.ssh/config";
      };

      # Copies your private identity key as a flat file to bypass symlink checks
      ssh_external_key = {
        path = "${config.home.homeDirectory}/.ssh/external_key";
        changeOwner = true;
      };

      # Copies your public identity key as a flat file
      ssh_external_pub = {
        path = "${config.home.homeDirectory}/.ssh/external_key.pub";
        changeOwner = true;
      };
    };
  };

  # Direct fail-safe ensuring the parent directory is established at boot
  home.file.".ssh/.keep".text = "";
}


