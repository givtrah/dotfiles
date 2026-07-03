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
      hosts = { mode = "0444"; }; # world readable (safe because its just local IPs/hostnames)
      work_timeserver = { mode = "0444"; }; # safe because its just a timeserver hostname
    };
  };

  environment.systemPackages = with pkgs; [ sops ];

}
