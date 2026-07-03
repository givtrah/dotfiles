{ config, pkgs, username, ... }:

{
  sops = {
    # This is the default secret file for everything in this module
    defaultSopsFile = ../secrets/secrets.yaml;
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

       # Define your user SSH files here at the system level!
      ssh_config = {
        path = "/home/${username}/.ssh/config";
        owner = username;
        mode = "0600";
      };
      ssh_external_key = {
        path = "/home/${username}/.ssh/external_key";
        owner = username;
        mode = "0600"; # Strict SSH private key permission
      };
      ssh_external_pub = {
        path = "/home/${username}/.ssh/external_key.pub";
        owner = username;
        mode = "0644"; # Public key readable by system
      };
    };
  };


  environment.systemPackages = with pkgs; [ sops ];

}
