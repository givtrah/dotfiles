{ config, pkgs, username, ... }:

{
  sops = {
    # This is the default secret file for everything in this module
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # This will automatically import the host's ssh key as an age key 
    # (Alternatively, point to /var/lib/sops-nix/key.txt if using a dedicated age key)
    age.keyFile = "/var/lib/sops-nix/keys.txt"; 
    
    # Secrets definition
    secrets = {
      test = {
        owner = "${username}";
      };
    };
  };
}
